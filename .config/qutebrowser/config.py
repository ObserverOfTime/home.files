config, c = config, c  # pyright: ignore

# Background color for webpages if unset.
c.colors.webpage.bg = ''

# Force prefers-color-scheme: dark colors for websites.
c.colors.webpage.preferred_color_scheme = 'dark'

# Require a confirmation before quitting the application.
c.confirm_quit = ['downloads']

# List of URLs to ABP-style adblocking rulesets. {{{1
c.content.blocking.adblock.lists = [
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt',  # noqa
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt',  # noqa
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt',  # noqa
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt',  # noqa
    'https://raw.githubusercontent.com/kargig/greek-adblockplus-filter/master/void-gr-filters.txt',  # noqa
    'https://raw.githubusercontent.com/ryanbr/fanboy-adblock/master/fanboy-antifacebook.txt',  # noqa
    'https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/nocoin.txt',  # noqa
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt',  # noqa
]
# }}}

# Default encoding to use for websites.
c.content.default_encoding = 'utf-8'

# Value to send in the Accept-Language header.
c.content.headers.accept_language = 'en-GB,en,el;q=0.9'

# User agent to send.
c.content.headers.user_agent = ' '.join((
    'Mozilla/5.0',
    '(X11; Linux x86_64)',
    'QtWebEngine/5.15.14',
    'Chromium/87.0.4280.144',
    'qutebrowser/3.0.0'
))

# Allow JavaScript to read from or write to the clipboard.
c.content.javascript.clipboard = 'access-paste'

# Allow pdf.js to view PDF files in the browser.
c.content.pdfjs = True

# Enable WebGL.
c.content.webgl = False

# Editor (and arguments) to use
# for the edit-text command.
c.editor.command = [
    'konsole', '-e',
    'nvim', '{file}',
    '-c', 'normal {line}G{column0}l'
]

# Command (and arguments) to use for selecting files in forms.
c.fileselect.single_file.command = \
    c.fileselect.multiple_files.command = \
    ['konsole', '-e', 'vifm', '--choose-files', '{}']

# Default monospace fonts.
c.fonts.web.family.fixed = 'Hack, Fira Code, Fantasque Sans Mono'

# Which Chromium process model to use.
c.qt.chromium.process_model = 'process-per-site'

# Languages to use for spell checking.
c.spellcheck.languages = ['en-GB', 'en-US', 'el-GR']

# When to show the statusbar.
c.statusbar.show = 'never'

# List of widgets displayed in the statusbar.
c.statusbar.widgets = ['keypress', 'url', 'history', 'tabs', 'progress']

# When to show the tab bar.
c.tabs.show = 'multiple'

# What search to start when something else than a URL is entered.
c.url.auto_search = 'never'

# Page to open if :open -t/-b/-w is used without URL. {{{1
c.url.default_page = """https://search.disroot.org/?preferences=
eJx1V02P4zYM_TXNxdgA2z0UPeTSAu1xC3TvAi0xNseS6NVHHM-vLxXbsTyZHsYY
kRJFPoqPjIaEHQfCeOnQYwB7suC7DB1e0H_5-4-TZQ22LE6QE2t2o8WEl58T-HQi
JxvVGPg-X36EjCeHqWdz-ef7vz9OEa4YEYLuL19PqUeHlxYxBeZ0ChizTVGxVx4n
laC9_AU24skwKVGyvWG4MMjyzKE7RSr3qphm8aU4ctLoEwYFljrv5P_1PJgbeI1G
rTcv0p8Zw6zIq0RJDCxC8lfylMSqDmzt5gBFaK0YQN-RF1x-76BTKrImsI1DQ_DL
r3_CODSOQuCg1JUsxodMXGzk28TEASuFOEI3bCgqtaL8kCbSSj0gLLta8EaDG5Vy
OZIuEkpt1gMm2ZVkrbX-km5K3cgglyM8ohecIlZmJJYYA17FZU0oUIhsxrG-Wedg
CT9Iguyda5lBfBeAn94Y0zUGH5AR-0MoGHgioxRLloOsJxrIQIKDOYmk_HXcLL5W
Ple6CaEY2W0tqDoY5YB8y22O32gsidh3JUnVfAjp67264GoCFwe3jFwt6SHUGwJi
E_maJgjYGAqoJYfzCvw1kB8I6mx11MkzgZgOMLLBFkO3HuuYO_F9tDCXZxH3-2uN
4xsVNJ5Z7UY2pka-hzZA-ax2-8fpdUHOtDsO5KGy9Eax5105SNAQKzcsieEwNyWC
SJ8o-Npo9p0UZJ0uy21MeA5xdQHe7RxIx91joQHQI_h1g6O7tpzNvsHPAPt15R3H
JClIkuEtzUUYcOTKrREkgI7iVhBjbs8Gb-vqQUmN0ImcKF8RRRwJFiaoYFkEJVlN
-TyTDA5K4JsgohODpJuoe7YQ6oqKScp3LORXpT_xMHNiwXwooW9ep4lSoaqPHJJ9
lAcQ-wrZGSS3tcmZc8otVs4_JRuUE7WHunUQhLgkkkP5CYffhWDCUVoKtWUe4kfh
AcUi-Jk54cddkXPQL9LCSJTmFzHPH_AypNM7-2PZfvv2233HzmSDfn_BEd89uEO0
_IY41BIPtwL2Lgi5nTt022sdEcMHTB8ZkSsGqcRpwrZShexaW--d-E4De3l3TZw9
-9lh5d_beB4nf2RCJ5RZ-yOldTvEPEq12O2Vfip-pcxaeXzyj5z0Oe0k9DR6Qn_s
bY_jlny-N8XTrZ7DnW71ay-6lXCrMMh3H9evfj6kBwcfkgXOCtY2Geq6KvF4I6k-
qbK6T7B0w9D0uV093RvHoR2l2bGXsKrMiJZyxVCyTgWZBSOZCqDdF_sF3Uq1u_GV
ul8CXeWHUFfZS7Cr_BNeIS-biHO9u5Jt3kts3e2QDT-6jWxBehVuvaKwKEg7K-04
okxc1WWbTmhU-iGsbX3Xj6ZUSbXuhd38xs8jBRkeW5grfs6tlNLhyDxSTc-1ywtf
vwC5iF8wkxAMpRcSlecuY9OxuQg564GFBa6Wp-1NxyG32ae8kXseMeT4xEkmTjLS
8mUMSlXHeRDyMakGyMr7KmhV7t3IIdc0QUPZAWWGeJIB26XJjH01ujhhECezRpMC
-GgF03qS4mA8DZUgpXCmimGkY62deB9dR5ulvuOl8MP9vK7OPcck7IkyX0vfWdrY
YYOEr3SPenjRSHRKkj_gHJ8c8j-XlIa2LF6sWKHCtPJ4LWdQy9g_BdG_qFdmFLj1
8mtlluHeyoD2yU57lSn_yq-hBSjUoWTylXtceRwnadcydlz-A1zR6ss=&q=%s
""".replace('\n', '')
# }}}

# Page(s) to open at the start.
c.url.start_pages = ['about:blank']

# Search engines which can be used via the address bar.
c.url.searchengines = {
    'DEFAULT': c.url.default_page + '&q={}',
    'G': 'https://google.com/search?q={}',
    'Q': 'https://qwant.com/?q={}'
}

# Keybindings {{{0
config.bind(';m', 'spawn mpv {url}')
config.bind(';M', 'hint links spawn mpv {hint-url}')
config.bind(';T', 'config-cycle -t tabs.show always multiple')
config.bind(';S', 'config-cycle -t statusbar.show always never')
config.bind('<F5>', 'reload -f')
config.bind('<Ctrl-Shift-I>', 'devtools window')
# }}}

# Disable autoconfig
config.load_autoconfig(False)

# vim:fdm=marker:fdl=0:
