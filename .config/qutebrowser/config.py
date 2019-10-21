config, c = config, c

# Default encoding to use for websites.
c.content.default_encoding = 'utf-8'

# Value to send in the Accept-Language header.
c.content.headers.accept_language = 'en_GB,en'

# User agent to send.
c.content.headers.user_agent = ' '.join((
    'Mozilla/5.0',
    '(X11; Linux x86_64)',
    'QtWebEngine/5.13.1',
    'Chromium/73.0.3683.105',
    'qutebrowser/1.8.1'
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
c.fonts.monospace = ','.join((
    'Hack',
    'Fira Code',
    'Code New Roman',
    'Fantasque Sans Mono',
    'DejaVu Sans Mono'
))

# Which Chromium process model to use.
c.qt.process_model = 'process-per-site'

# Languages to use for spell checking.
c.spellcheck.languages = [
    'en-GB',
    'en-US',
    'el-GR'
]

# List of widgets displayed in the statusbar.
c.statusbar.widgets = [
    'keypress',
    'url',
    'history',
    'tabs',
    'progress'
]

# Page(s) to open at the start.
c.url.start_pages = [  # {{{1
    """https://search.disroot.org/?preferences=
    eJx1lMFu2zAMhp9mvhgZtvWwkw_DimEFBrRY0l0FWmJ
    szrJoiHIS7-lHJXHsdt3Fhkjx50eKUkQZfRLDwQQ8mg
    R19Q28YOGYTERhf8BYiaVNO9bv07HwEJoRGqwwbJ63h
    WcLPi8KRwK1R2cGPzYUpCqo131miHyaql0csYAxseV-
    8JiwKgT2KAjRttWHIrXYY8ViIRYYXgo9Dhgyi4IaT6G
    70daRj4IxU8u7T18fwp4CJTRiI3uvlu-73dNWQ49Rzb
    reRbCdBjz__KHWnrU2tf6ifuOpQ9Ny6nDKUlv0e6N6H
    HtIxOFiy6w5t4WEDcfJCHq0SX1nxC_Wooi5f3yYUy5N
    waCloFT7iFgK79MRIpaOosZnJUNZ5sCQjBG2BL7s0RG
    okQIYcyCHnCnGIIMHaTUitzebGubGY6nmqYRhEGP25M
    -e-9Epl2kwYITcEGvtJh1Wcg01CgiS1rtaqCPkzxUrT
    AD_ydePQtaY809dEwSHp7UW2EZ4XHY0iF2iHuWF9uzt
    SY8ut6cECw77rK3Dh8Hm43PU1GkFP2sv1azJ-EA5y83
    58bSqQRDdgDoKS2r-rWhvob8RdBNFHUFy66g9RGaT5z
    P7PWkr41Rmv5C8kNdpogOWL601pXrUIU3X_kzQZrmVf
    tQrQGBXXIm7iRNLyx2EpaIryRJ66fWNvZ96vQMKlyIE
    8TrU7q3y52Fqz829Yi2tmN0X8Xn1CumW83qEM-KrbXO
    04J8A_RpGjiRi9bqvj8NCiKWkONo0xnzWy6hcHhbLDs
    v8makXlUX6493d59O_iGeW21s039-ix9Syq54et7vi-
    g7omFVXueL8gm0kTfooem4oJz9sHMTuL4eaCf8=
    """.replace('\n', '').replace(' ', ''),
]  # }}}

# Search engines which can be used via the address bar.
c.url.searchengines = {
    'DEFAULT': c.url.start_pages[0] + '&q={}',
    'G': 'https://google.com/?q={}',
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
