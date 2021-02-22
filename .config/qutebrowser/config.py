config, c = config, c

# Background color for webpages if unset.
c.colors.webpage.bg = ''

# Force prefers-color-scheme: dark colors for websites.
c.colors.webpage.prefers_color_scheme_dark = True

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
    'QtWebEngine/5.15.2',
    'Chromium/83.0.4103.122',
    'qutebrowser/2.0.2'
))

# Allow JavaScript to read from or write to the clipboard.
c.content.javascript.can_access_clipboard = True

# Allow pdf.js to view PDF files in the browser.
c.content.pdfjs = True

# Validate SSL handshakes.
c.content.ssl_strict = True

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
c.qt.process_model = 'process-per-site'

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
eJx1VU3P2zYM_jXzxUixroedfBg2DCtQ4C2adFeDlmibjSS6opy83q8fFX_EedNe
Elgm-XyQoiPK6JLUHOqA1zpBU_0NTrCwTHVEYXfBWImhQz8279K1cBC6ETqsMBy-
HgvHBlx-KCwJNA5tPbixoyDVv-QPjs5Y95zOOMkvv_35MmDIVRWydhTOG24T-SoY
M36O-xhaCpSwFhPZuTXzD2NQpP7r5aMWuUYNKMgrl3qI_DpVpzhiAWNiw35wmLAq
BFoUhGj66tci9eixYjEQCwyPZI_o2lphOXpIxCGzOEUwZyX19csnxfOsTujpP6fT
5-OKr8_HW_ksxEDCjuNUCzo06e4IBsVAqVhFAEUcxsaRmXFq1UgYTC7VRsRSuE1X
iFhajTQp16sp6dsLQ9JoNgSu9GgJ9LABwX2JMAHU9YUscpYwBhkcSK8lslH5qGPu
HJZ6PJUwDEqgJXd7Y6lr0v1xsM1D6Y46lQOiIR0GjJD7EtFa0hNtYs7RdolEbPd5
gh5CIlOK6dlBfKa7cVsNspBUV3owZ8_bj0Kmrm9_GdWYQ7rsZK-s7jw7xHMij7KY
SWFvk6dMXI0vwYBFn4vfkRdftuiFyfy8OwfTCY_PgTNlvhDuo9-_7oTb0ep87_gK
oh1Qh28Tqe8S80LfjDEqu2mf4unVOB7tPeX7VY0v54l5mhzUK0d2X6CFmAGWVvbQ
RMg_C2SecrpgSbLPWTWvkG3Ua01gdtoSnydOLD2fIewiZ7QfSd48aiN4cNREXEhM
0DOXmeHG009e72acyhQhiNM7aH9EcJ1qz990FPYRs0sPNR03kvBdXKelvzVyebjz
XGu-UbjRXwZnVfwmbM0W_C-Af3DCQIilpDiaNEaUN8PYPfVyXnGGLZb5ZyGqa8Zn
M-7J7z98-P11R3CXZ9ksadZ2pcXbAp4X1LOZc2-3Jbrut2XeH63U7oF2JxeRx9lZ
wn-6FlaD1tv8RnS3NOWp4MxuN4ENpWbUVZ4WhWvBLWDGu_Wp8Jh6ttXnl-OpWDY6
ZW0zSnH7fBwkTfrVc9xRNu9ysBDP_wMVWr6s""".replace('\n', '')
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
