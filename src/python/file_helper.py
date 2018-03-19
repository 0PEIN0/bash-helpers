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

    def copy_and_replace_single_file(self,
                                     source_path,
                                     destination_path):
        file_content = self.read_file(dir_path=source_path)
        self.write_on_file_force(dir_path=destination_path,
                                 file_content=file_content)

    def copy_and_replace_files(self,
                               file_path_def_list):
        for item in file_path_def_list:
            self.copy_and_replace_single_file(source_path=item['source'],
                                              destination_path=item['destination'])
