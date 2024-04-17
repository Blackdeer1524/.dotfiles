local web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")
if not web_devicons_ok then
    return
end

local material_icon_ok, material_icon = pcall(require, "nvim-material-icon")
if not material_icon_ok then
    return
end

local audio_ext_cfg = {}
for _, v in pairs({ "mp3", "wav", "aac", "flac", "m4a", "wma", "ogg", "opus", "aiff", "au" }) do
    audio_ext_cfg[v] = {
        icon = "",
        name = v,
        color = "#672168"
    }
end
audio_ext_cfg["pyw"] = {
    icon = "󰌠",
    name = "PythonNoConsole"
}
audio_ext_cfg["apkg"] = {
    icon = "󰘸",
    name = "AnkiPackage"
}
audio_ext_cfg["proto"] = {
    icon = "󱁜",
    name = "protobufs"
}
audio_ext_cfg["ev"] = audio_ext_cfg["proto"]

web_devicons.setup({
    -- globally enable different highlight colors per icon (default to true)
    -- if set to false all icons will have the default icon's color
    color_icons = true,
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    -- globally enable "strict" selection of icons - icon will be looked up in
    -- globally enable "strict" selection of icons - icon will be looked up in
    -- globally enable "strict" selection of icons - icon will be looked up in
    default = true,
    -- globally enable "strict" selection of icons - icon will be looked up in
    -- different tables, first by filename, and if not found by extension; this
    -- prevents cases when file doesn't have any extension but still gets some icon
    -- because its name happened to match some extension (default to false)
    strict = true,
    -- same as `override` but specifically for overrides by filename
    -- takes effect when `strict` is true
    override_by_filename = {
        -- [".gitignore"] = {
        --     icon = "",
        --     name = "Gitignore"
        -- }
    },
    override = material_icon.get_icons(),
    override_by_extension = audio_ext_cfg,
})
