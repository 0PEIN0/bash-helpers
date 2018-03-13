import os
import re

from file_helper import FileHelper
from local_settings_loader import LocalSettingsLoader
from shell_executor import ShellExecutor


class YoutubeMusicVideoSync(object):

    YOUTUBE_VIDEO_ID_LIST = {}
    YOUTUBE_VIDEO_ID_LENGTH = 11

    def __init__(self):
        self.YOUTUBE_VIDEO_ID_LIST = LocalSettingsLoader(
        ).LOCAL_SETTINGS['YOUTUBE_VIDEO_ID_LIST']
        self.file_helper_obj = FileHelper()
        self.shell_executor = ShellExecutor()

    def sync_mvs(self):
        mv_folder_path = self.shell_executor.execute_shell_command(
            cmd='echo $SYSTEM_MUSIC_VIDEOS_FOLDER')
        file_name_list = os.listdir(mv_folder_path[0])
        existing_mv_list = []
        for file_name in file_name_list:
            file_name = file_name.split('.')[:-1]
            file_name = ''.join(file_name)
            parts = file_name.split('-')
            parts_len = len(parts)
            file_name = ''
            for i in range(0, parts_len):
                if i is 0:
                    file_name = parts[parts_len - i - 1]
                else:
                    file_name = '{}-{}'.format(
                        parts[parts_len - i - 1], file_name)
                if len(file_name) >= self.YOUTUBE_VIDEO_ID_LENGTH:
                    break
            if len(file_name) == self.YOUTUBE_VIDEO_ID_LENGTH and ' ' not in file_name:
                existing_mv_list.append(file_name)
        for item in self.YOUTUBE_VIDEO_ID_LIST:
            if item not in existing_mv_list:
                self.shell_executor.execute_shell_command(
                    cmd='downloadYoutubeVideo {video_id}'.format(video_id=item))
        for item in existing_mv_list:
            if item not in self.YOUTUBE_VIDEO_ID_LIST:
                self.YOUTUBE_VIDEO_ID_LIST.append(item)
                dir_path = os.path.dirname(os.path.realpath(__file__))
                file_path = os.path.join(dir_path, 'local_settings.py')
                file_content = self.file_helper_obj.read_file(
                    dir_path=file_path)
                replace_str = '\'' + item + '\',\n                              '
                file_content = re.sub(
                    r'(\'YOUTUBE_VIDEO_ID_LIST\': \[)', r'\1{replace_str}'.format(replace_str=replace_str), file_content)
                self.file_helper_obj.write_on_file_force(dir_path=file_path,
                                                         file_content=file_content)


YoutubeMusicVideoSync().sync_mvs()
