from local_settings_loader import LocalSettingsLoader


class YoutubeMusicVideoSync(object):

    YOUTUBE_VIDEO_ID_LIST = {}

    def __init__(self):
        self.YOUTUBE_VIDEO_ID_LIST = LocalSettingsLoader(
        ).LOCAL_SETTINGS['YOUTUBE_VIDEO_ID_LIST']
        print(66, self.YOUTUBE_VIDEO_ID_LIST)
