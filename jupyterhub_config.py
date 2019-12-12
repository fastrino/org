# jupyterhub_config.py
c = get_config()

import os
pjoin = os.path.join

runtime_dir = os.path.join('/srv/jupyterhub')
ssl_dir = pjoin(runtime_dir, 'ssl')
if not os.path.exists(ssl_dir):
    os.makedirs(ssl_dir, exist_ok=True)

# https on :8000
## c.JupyterHub.port = 8000
#c.JupyterHub.ssl_key = '/etc/letsencrypt/live/rich2019.com/privkey.pem'
#c.JupyterHub.ssl_cert = '/etc/letsencrypt/live/rich2019.com/fullchain.pem'
c.JupyterHub.ssl_key = pjoin(ssl_dir, 'ssl.key')
c.JupyterHub.ssl_cert = pjoin(ssl_dir, 'ssl.cert')

# put the JupyterHub cookie secret and state db
# in /var/run/jupyterhub
c.JupyterHub.cookie_secret_file = pjoin(runtime_dir, 'cookie_secret')
c.JupyterHub.db_url = pjoin(runtime_dir, 'jupyterhub.sqlite')
c.JupyterHub.pid_file = pjoin(runtime_dir, 'jupyterhub_proxy.pid')
# or `--db=/path/to/jupyterhub.sqlite` on the command-line

# put the log file in /var/log
c.JupyterHub.extra_log_file = '/var/log/jupyterhub.log'

# use GitHub OAuthenticator for local users

#c.JupyterHub.authenticator_class = 'oauthenticator.LocalGitHubOAuthenticator'
#c.GitHubOAuthenticator.oauth_callback_url = os.environ['OAUTH_CALLBACK_URL']
# create system users that don't exist yet
c.LocalAuthenticator.create_system_users = True

# specify users and admin
c.Authenticator.whitelist = {'admin'}
c.Authenticator.admin_users = {'admin'}
