import sys

from file_helper import FileHelper
from git_operations import GitOperations
from local_settings_loader import LocalSettingsLoader
from youtube_music_video_sync import YoutubeMusicVideoSync


class DailyLocalMachineOperations(object):

    def __init__(self):
        if '-before-file-replace' in sys.argv:
            print('INFO: pre-processing file replaces started.....')
            FileHelper().copy_and_replace_files(
                file_path_def_list=LocalSettingsLoader().LOCAL_SETTINGS['FILE_REPLACE_DEF_LIST_BEFORE_DAILY_OPERATION'])
            print('INFO: pre-processing file replaces completed.')
        if '-music-sync' in sys.argv:
            print('INFO: music video file sync started.....')
            YoutubeMusicVideoSync().sync_mvs()
            print('INFO: music video file sync completed.')
        if '--clone-repos' in sys.argv:
            print('INFO: git repo clone check started.....')
            GitOperations().clone_from_provider()
            print('INFO: git repo clone check completed.')
        if '-git-repos-sync' in sys.argv:
            print('INFO: git repos sync started.....')
            GitOperations().fetch_all_repos_and_reset_hard()
            print('INFO: git repos sync completed.')
        if '-after-file-replace' in sys.argv:
            print('INFO: post-processing file replaces started.....')
            FileHelper().copy_and_replace_files(
                file_path_def_list=LocalSettingsLoader().LOCAL_SETTINGS['FILE_REPLACE_DEF_LIST_AFTER_DAILY_OPERATION'])
            print('INFO: post-processing file replaces completed.')


DailyLocalMachineOperations()
