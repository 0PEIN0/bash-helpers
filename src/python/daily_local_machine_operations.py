from file_helper import FileHelper
from git_operations import GitOperations
from local_settings_loader import LocalSettingsLoader
from youtube_music_video_sync import YoutubeMusicVideoSync


class DailyLocalMachineOperations(object):

    def __init__(self):
        FileHelper().copy_and_replace_files(
            file_path_def_list=LocalSettingsLoader().LOCAL_SETTINGS['FILE_REPLACE_DEF_LIST'])
        YoutubeMusicVideoSync().sync_mvs()
        GitOperations().fetch_all_repos_and_reset_hard()


DailyLocalMachineOperations()
