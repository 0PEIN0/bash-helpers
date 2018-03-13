class FileHelper(object):

    def read_file(self,
                  dir_path):
        try:
            file_obj = open(dir_path, 'r')
            file_content = file_obj.read()
            file_obj.close()
        except Exception:
            raise Exception('FATAL ERROR: error occured during reading a file. File path: {dir_path}'.format(
                dir_path=dir_path))
        return file_content

    def write_on_file_force(self,
                            dir_path,
                            file_content):
        file_obj = open(dir_path, 'w')
        file_obj.write(file_content)
        file_obj.close()
