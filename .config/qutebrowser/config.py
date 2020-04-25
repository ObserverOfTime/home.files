config, c = config, c

# Default encoding to use for websites.
c.content.default_encoding = 'utf-8'

# Value to send in the Accept-Language header.
c.content.headers.accept_language = 'en_GB,en'

# User agent to send.
c.content.headers.user_agent = ' '.join((
    'Mozilla/5.0',
    '(X11; Linux x86_64)',
    'QtWebEngine/5.14.2',
    'Chromium/77.0.3865.129',
    'qutebrowser/1.10.2'
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
# for the open-editor command.
c.editor.command = [
    'konsole', '-e',
    'nvim', '{file}',
    '-c', 'normal {line}G{column0}l'
]

# Default monospace fonts.
c.fonts.web.family.fixed = ','.join((
    'Hack',
    'Fira Code',
    'Code New Roman',
    'Fantasque Sans Mono',
    'DejaVu Sans Mono'
))

# Which Chromium process model to use.
c.qt.process_model = 'process-per-site'

# Languages to use for spell checking.
c.spellcheck.languages = ['en-GB', 'en-US', 'el-GR']

# List of widgets displayed in the statusbar.
c.statusbar.widgets = ['keypress', 'url', 'history', 'tabs', 'progress']

c.url.start_pages = [
    # {{{1
    """https://search.disroot.org/?preferences=
    eJx1VU3P2zYM_jXzxUixroedfBg2DCtQ4C2adFeDlmi
    bjSS6opy83q8fFX_EedNeElgm-XyQoiPK6JLUHOqA1z
    pBU_0NTrCwTHVEYXfBWImhQz8279K1cBC6ETqsMBy-H
    gvHBlx-KCwJNA5tPbixoyDVv-QPjs5Y95zOOMkvv_35
    MmDIVRWydhTOG24T-SoYM36O-xhaCpSwFhPZuTXzD2N
    QpP7r5aMWuUYNKMgrl3qI_DpVpzhiAWNiw35wmLAqBF
    oUhGj66tci9eixYjEQCwyPZI_o2lphOXpIxCGzOEUwZ
    yX19csnxfOsTujpP6fT5-OKr8_HW_ksxEDCjuNUCzo0
    6e4IBsVAqVhFAEUcxsaRmXFq1UgYTC7VRsRSuE1XiFh
    ajTQp16sp6dsLQ9JoNgSu9GgJ9LABwX2JMAHU9YUscp
    YwBhkcSK8lslH5qGPuHJZ6PJUwDEqgJXd7Y6lr0v1xs
    M1D6Y46lQOiIR0GjJD7EtFa0hNtYs7RdolEbPd5gh5C
    IlOK6dlBfKa7cVsNspBUV3owZ8_bj0Kmrm9_GdWYQ7r
    sZK-s7jw7xHMij7KYSWFvk6dMXI0vwYBFn4vfkRdftu
    iFyfy8OwfTCY_PgTNlvhDuo9-_7oTb0ep87_gKoh1Qh
    28Tqe8S80LfjDEqu2mf4unVOB7tPeX7VY0v54l5mhzU
    K0d2X6CFmAGWVvbQRMg_C2SecrpgSbLPWTWvkG3Ua01
    gdtoSnydOLD2fIewiZ7QfSd48aiN4cNREXEhM0DOXme
    HG009e72acyhQhiNM7aH9EcJ1qz990FPYRs0sPNR03k
    vBdXKelvzVyebjzXGu-UbjRXwZnVfwmbM0W_C-Af3DC
    QIilpDiaNEaUN8PYPfVyXnGGLZb5ZyGqa8ZnM-7J7z9
    8-P11R3CXZ9ksadZ2pcXbAp4X1LOZc2-3Jbrut2XeH6
    3U7oF2JxeRx9lZwn-6FlaD1tv8RnS3NOWp4MxuN4ENp
    WbUVZ4WhWvBLWDGu_Wp8Jh6ttXnl-OpWDY6ZW0zSnH7
    fBwkTfrVc9xRNu9ysBDP_wMVWr6s
    """.replace('\n', '').replace(' ', '')
    # }}}
]

# Search engines which can be used via the address bar.
c.url.searchengines = {
    'DEFAULT': c.url.start_pages[0] + '&q={}',
    'G': 'https://google.com/search?q={}',
    'Q': 'https://qwant.com/?q={}'
}

# Keybindings {{{0
config.bind('<Ctrl-Shift-I>', 'inspector')
config.bind(';m', 'spawn mpv {url}')
config.bind(';M', 'hint links spawn mpv {hint-url}')
# }}}

# Load autoconfig.yml
config.load_autoconfig()

# vim:fdm=marker:fdl=0:
