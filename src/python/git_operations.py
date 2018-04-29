import getpass

from local_settings_loader import LocalSettingsLoader
from shell_executor import ShellExecutor


class GitOperations(object):

    def __init__(self):
        self.local_settings_loader_obj = LocalSettingsLoader()
        self.shell_executor_obj = ShellExecutor()
        self.system_user_name = getpass.getuser()
        self.git_folder_path = 'cd $SYSTEM_ROOT_GIT_REPO_FOLDER/'.format(
            system_user_name=self.system_user_name)

    def perform_git_clone(self, git_url):
        self.shell_executor_obj.execute_shell_command(
            cmd='{git_folder_path} && git clone {git_url}'.format(git_folder_path=self.git_folder_path, git_url=git_url))

    def get_project_folder_list(self):
        project_folder_list = self.shell_executor_obj.execute_shell_command(
            cmd='{git_folder_path} && ls -l'.format(git_folder_path=self.git_folder_path))
        del project_folder_list[0]
        project_folder_list = project_folder_list[:-1]
        project_name_list = []
        for project_folder in project_folder_list:
            parts = project_folder.split(' ')
            project_name = parts[len(parts) - 1]
            project_name_list.append(project_name)
        return project_name_list

    def clone_from_provider(self, provider_name, repo_list):
        project_name_list = self.get_project_folder_list()
        for item in repo_list:
            repo_name = item.split('/')[1]
            found = False
            for already_cloned_item in project_name_list:
                if repo_name in already_cloned_item:
                    found = True
                    break
            if found is True:
                print('======>>>>>', item, 'PREVIOUSLY CLONED')
                continue
            full_url = 'git@{provider_name}:{actual_path}.git'.format(
                provider_name=provider_name,
                actual_path=item)
            self.perform_git_clone(git_url=full_url)
            print('======>>>>>', item, 'CLONED')

    def clone_missing_repos(self):
        github_repo_list = self.local_settings_loader_obj.LOCAL_SETTINGS['GITHUB_REPO_LIST']
        bit_bucket_repo_list = self.local_settings_loader_obj.LOCAL_SETTINGS[
            'BIT_BUCKET_REPO_LIST']
        gitlab_repo_list = self.local_settings_loader_obj.LOCAL_SETTINGS['GITLAB_REPO_LIST']
        self.clone_from_provider(
            provider_name='github.com', repo_list=github_repo_list)
        self.clone_from_provider(
            provider_name='bitbucket.org', repo_list=bit_bucket_repo_list)
        self.clone_from_provider(
            provider_name='gitlab.com', repo_list=gitlab_repo_list)

    def fetch_all_repos_and_reset_hard(self):
        project_name_list = self.get_project_folder_list()
        for project_name in project_name_list:
            project_folder_path = '{git_folder_path}{project_name}/'.format(
                git_folder_path=self.git_folder_path,
                project_name=project_name)
            self.shell_executor_obj.execute_shell_command(
                cmd='{project_folder_path} && printf "yes\n" | git fetch --all && gitResetHard'.format(project_folder_path=project_folder_path))
            branch_name = self.shell_executor_obj.execute_shell_command(
                cmd='{project_folder_path} && git branch'.format(project_folder_path=project_folder_path))
            branch_name = branch_name[0].replace('* ', '')
            print('======>>>>>', project_name, branch_name, 'DONE')
