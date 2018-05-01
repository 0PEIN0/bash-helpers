import sys

from file_helper import FileHelper
from git_operations import GitOperations
from local_settings_loader import LocalSettingsLoader
from youtube_music_video_sync import YoutubeMusicVideoSync


class DailyLocalMachineOperations(object):

    def __init__(self):
        if '-before-file-replace' in sys.argv:
            print('INFO: pre-processing file replaces started.....')
            try:
                FileHelper().copy_and_replace_files(
                    file_path_def_list=LocalSettingsLoader().LOCAL_SETTINGS['FILE_REPLACE_DEF_LIST_BEFORE_DAILY_OPERATION'])
            except Exception as ex:
                print('ERROR: pre-processing file replaces error.', ex)
            print('INFO: pre-processing file replaces completed.')
        if '-music-sync' in sys.argv:
            print('INFO: music video file sync started.....')
            try:
                YoutubeMusicVideoSync().sync_mvs()
            except Exception as ex:
                print('ERROR: music video file sync error.', ex)
            print('INFO: music video file sync completed.')
        if '-clone-repos' in sys.argv:
            print('INFO: git repo clone check started.....')
            try:
                GitOperations().clone_missing_repos()
            except Exception as ex:
                print('ERROR: git repo clone check error.', ex)
            print('INFO: git repo clone check completed.')
        if '-git-repos-sync' in sys.argv:
            print('INFO: git repos sync started.....')
            try:
                GitOperations().fetch_all_repos_and_reset_hard()
            except Exception as ex:
                print('ERROR: git repos sync error.', ex)
            print('INFO: git repos sync completed.')
        if '-after-file-replace' in sys.argv:
            print('INFO: post-processing file replace started.....')
            try:
                FileHelper().copy_and_replace_files(
                    file_path_def_list=LocalSettingsLoader().LOCAL_SETTINGS['FILE_REPLACE_DEF_LIST_AFTER_DAILY_OPERATION'])
            except Exception as ex:
                print('ERROR: post-processing file replace error.', ex)
            print('INFO: post-processing file replace completed.')


DailyLocalMachineOperations()
