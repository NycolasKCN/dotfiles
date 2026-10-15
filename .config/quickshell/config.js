const colors = {
    primary: "#9DCBFB",
    secondary: "#B9C8DA",
    terciary: "#C8B7DD",
    error: "#FFB4AB",
    background: "#070808",
    foreground: "#FAFAFA"
};

const fonts = {
    primary: "NotoSans Nerd Font",
    secondary: "Inter",
    size: {
        verySmall: 9,
        small: 10,
        normal: 11,
        big: 13
    },
    weight: {
        medium: 600,
        bold: 700
    }
};

const sizes = {
    bar: {
        height: 28,
        width: 1000
    },
    radius: {
        small: 4,
        medium: 6,
        normal: 8
    },
    margin: {
        small: 4,
        normal: 6,
        medium: 8,
        big: 16
    }
};

const icons = {
    workspaces: {
        "1": "一",
        "2": "二",
        "3": "三",
        "4": "四",
        "5": "五",
        "6": "六",
        "7": "七",
        "8": "八",
        "9": "九",
        "10": "十",
        "special:notes": "󰺿",
        "special:music": "",
        "special:terminal": "",
        "special:magic": "",
        "special:magic2": ""
    },
    workspace: function(name, fallback) {
        return this.workspaces[name] ?? fallback;
    }
};
