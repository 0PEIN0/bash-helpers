import sys

from file_helper import FileHelper
from git_operations import GitOperations
from local_settings_loader import LocalSettingsLoader
from youtube_music_video_sync import YoutubeMusicVideoSync


class DailyLocalMachineOperations(object):

    def __init__(self):
        if '-before-file-replace' in sys.argv:
            FileHelper().copy_and_replace_files(
                file_path_def_list=LocalSettingsLoader().LOCAL_SETTINGS['FILE_REPLACE_DEF_LIST_BEFORE_DAILY_OPERATION'])
        if '-music-sync' in sys.argv:
            YoutubeMusicVideoSync().sync_mvs()
        if '-git-repos-sync' in sys.argv:
            GitOperations().fetch_all_repos_and_reset_hard()
        if '-after-file-replace' in sys.argv:
            FileHelper().copy_and_replace_files(
                file_path_def_list=LocalSettingsLoader().LOCAL_SETTINGS['FILE_REPLACE_DEF_LIST_AFTER_DAILY_OPERATION'])


DailyLocalMachineOperations()
