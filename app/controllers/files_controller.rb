class FilesController < ApplicationController

  def upload

      uploaded_io = params[:file]
      File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.tempfile.read)
      end
      ModelProcessor.process(Rails.root.join('public', 'uploads', uploaded_io.original_filename))
      render json: {:name => uploaded_io.original_filename, :status => "success"}
  end
end
