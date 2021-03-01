# frozen_string_literal: true

class Uploader
  class NoFileSelected < RuntimeError; end

  def upload_all(files)
    files.map do
      upload(_1[:tempfile], _1[:filename])
    end
  end

  def upload(tempfile, filename)
    raise NoFileSelected if tempfile.nil? || filename.nil?

    ext_name = File.extname(filename)
    new_filename = "#{Time.now.to_i.to_s(16)}#{SecureRandom.hex(4)}#{ext_name}"
    path = File.join(Dir.pwd, "public/files/#{new_filename}")

    File.open(path, 'wb') do
      _1.write(tempfile.read)
    end

    {
      new_name: new_filename,
      original_name: filename,
      size: File.size(path)
    }
  end
end
