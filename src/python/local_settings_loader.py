class LocalSettingsLoader(object):

    LOCAL_SETTINGS = {}

    def __init__(self):
        try:
            from local_settings import LOCAL_SETTINGS
        except Exception:
            print(
                'FATAL ERROR: could not import local settings file. Are you sure the `local_settings.py` file exists?')
        self.LOCAL_SETTINGS = LOCAL_SETTINGS
