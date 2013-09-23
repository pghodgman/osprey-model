class ModelProcessor
  def self.process(model_filename)

    puts model_filename
    model_file = File.open(model_filename, 'rb')

    puts 'verifying file'
    raise Exception  unless verify(model_file)

    puts 'getting block directory'
    directory = get_block_directory(model_file)

    model = Model.create
    model.name = File.basename(model_filename, '.rb')
    model.save


    puts 'getting bodies'
    get_bodies(model, model_file, directory['SOLD'])
    get_location(model, model_file, directory['IMAG'])
    get_preview(model, model_file, directory['PRVW'])
    get_meta(model, model_file, directory['META'])
    get_levels(model, model_file, directory['LEVS'])


  end

  def self.get_block_directory(model_file)

    # skip header
    model_file.read(153)

    number_of_entries = model_file.read(4).unpack("L").first
    block_directory = Hash.new

    number_of_entries.times do |n|
      name = model_file.read(4)
      offset = model_file.read(4).unpack("L").first
      block_directory[name] = offset
    end

    puts block_directory
    block_directory
  end

  def self.verify(model_file)
    model_file.seek(34389,IO::SEEK_SET)
    file_signature = model_file.read(16)
    expected_signature = [0x6D, 0x63, 0xFB, 0x70, 0xC9, 0x40, 0x4F, 0x06, 0x91, 0x92, 0x9F, 0xDF, 0x8B, 0x0D, 0xE5, 0xFB]
    puts file_signature
    puts expected_signature
    file_signature.bytes == expected_signature
  end


  def self.get_bodies(model, model_file, offset)
    model_file.seek(offset, IO::SEEK_SET)

    # blockid, version, checksum, size
    model_file.read(16)

    # number of bodies to follow
    number_of_solids = model_file.read(4).unpack("L").first
    puts number_of_solids

    number_of_solids.times do |n|

      #basics
      block_id = model_file.read(4).unpack("L").first
      version = model_file.read(4).unpack("L").first
      size = model_file.read(4).unpack("L").first
      cksum = model_file.read(4).unpack("L").first
      type = model_file.read(4).unpack("L").first

      #body data
      data = model_file.read(size - 4)

      info = {:block_id => block_id, :version => version, :size => size, :cksum => cksum, :type => type}
      puts info
      puts data

      # body meta-data
      meta_id = model_file.read(4).unpack("L").first
      meta_version = model_file.read(4).unpack("L").first
      meta_size = model_file.read(4).unpack("L").first
      meta_cksum = model_file.read(4).unpack("L").first
      meta_data = model_file.read(meta_size)
      meta_info = {:meta_id => meta_id, :meta_version => meta_version, :meta_size => meta_size, :meta_cksum => meta_cksum}
      puts meta_info
      puts meta_data

      #xform version info
      model_file.read(16)


      # xform
      #
      x = model_file.read(8).unpack("D").first
      y = model_file.read(8).unpack("D").first
      z = model_file.read(8).unpack("D").first

      rot_x = model_file.read(8).unpack("D").first
      rot_y = model_file.read(8).unpack("D").first
      rot_z = model_file.read(8).unpack("D").first
      rot_w = model_file.read(8).unpack("D").first

      scale_x = model_file.read(8).unpack("D").first
      scale_y = model_file.read(8).unpack("D").first
      scale_z = model_file.read(8).unpack("D").first

      xform = {:x => x, :y => y, :z => z, :rot_x => rot_x, :rot_y => rot_y, :rot_z => rot_z, :rot_w => rot_w, :scale_x => scale_x, :scale_y => scale_y, :scale_z => scale_z}
      puts xform

      body = Body.new
      body.model = model
      body.version = version
      body.kind = type
      body.data = data

      transform = Transform.new
      transform.x = x
      transform.y = y
      transform.z = z
      transform.xrot = rot_x
      transform.yrot = rot_y
      transform.zrot = rot_z
      transform.wrot = rot_w
      transform.xscale = scale_x
      transform.yscale = scale_y
      transform.zscale = scale_z

      body.save
      transform.body = body
      transform.save

    end
  end

  def self.get_location(model, model_file, offset)
    model_file.seek(offset, IO::SEEK_SET)

    # header for block
    model_file.read(16)

    # meta-data
    kind = model_file.read(4).unpack("L").first
    image_size = model_file.read(4).unpack("L").first
    width = model_file.read(8).unpack("Q").first
    height = model_file.read(8).unpack("Q").first

    # sat info
    latitude = model_file.read(8).unpack("D").first
    longitude = model_file.read(8).unpack("D").first
    latspan = model_file.read(8).unpack("D").first
    longspan = model_file.read(8).unpack("D").first
    latpix = model_file.read(4).unpack("L").first
    longpix = model_file.read(4).unpack("L").first

    image_data = model_file.read(image_size)

    location = Location.new
    location.latitude = latitude
    location.longitude = longitude
    location.latspan = latspan
    location.longspan = longspan
    location.image = image_data
    location.model = model
    location.save
  end

  def self.get_preview(model, model_file, offset)
    model_file.seek(offset, IO::SEEK_SET)

    block_id = model_file.read(4).unpack("L").first
    version = model_file.read(4).unpack("L").first
    size = model_file.read(4).unpack("L").first
    cksum = model_file.read(4).unpack("L").first

    data = model_file.read(size)


    model.preview = data
    model.save

  end

  def self.get_meta(model, model_file, offset)
    model_file.seek(offset, IO::SEEK_SET)

    block_id = model_file.read(4).unpack("L").first
    version = model_file.read(4).unpack("L").first
    size = model_file.read(4).unpack("L").first
    cksum = model_file.read(4).unpack("L").first

    buildable_area = model_file.read(8).unpack("Q").first
    area_of_site = model_file.read(8).unpack("Q").first
    gross_area = model_file.read(8).unpack("Q").first


    model.buildable_area = buildable_area
    model.area_of_site = area_of_site
    model.gross_area = gross_area
    model.save
  end

  def self.get_levels(model, model_file, offset)
    model_file.seek(offset, IO::SEEK_SET)

    block_id = model_file.read(4).unpack("L").first
    version = model_file.read(4).unpack("L").first
    size = model_file.read(4).unpack("L").first
    cksum = model_file.read(4).unpack("L").first

    num_levels = model_file.read(4).unpack("L").first

    num_levels.times do |n|
      # skip header
      model_file.read(16)

      # level
      uuid = model_file.read(16)
      elevation = model_file.read(8).unpack("D").first
      namesize = model_file.read(4).unpack("L").first
      name = model_file.read(namesize)

      level = Level.new
      level.uuid = uuid
      level.elevation = elevation
      level.name = name
      level.model = model
      level.save


    end


  end



end