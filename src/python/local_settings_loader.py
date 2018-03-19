class LocalSettingsLoader(object):

    LOCAL_SETTINGS = {}

    def __init__(self):
        try:
            from local_settings import LOCAL_SETTINGS
        except Exception:
            print(
                'FATAL ERROR: could not import local settings file. Are you sure the `local_settings.py` file exists?')
        self.LOCAL_SETTINGS = LOCAL_SETTINGS
        self._initializer_empty_lists()

    def _initializer_empty_lists(self):
        for item in ['FILE_REPLACE_DEF_LIST', 'YOUTUBE_VIDEO_ID_LIST', ]:
            if self.LOCAL_SETTINGS[item] is None:
                self.LOCAL_SETTINGS[item] = []
