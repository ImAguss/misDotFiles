-- ~/.config/nvim/colors/obsidian_master.lua
-- Tema: Obsidian Master (Mejorado)
-- Enfoque: Transparencia, legibilidad y armonía cromática.

local colors = {
  -- Base (Definen el tono, aunque Normal usará NONE para transparencia)
  bg0 = "#1f1a24", -- fondo principal teórico
  bg1 = "#2a2232", -- elementos sutiles sobre el fondo (CursorLine)
  bg2 = "#3a2f44", -- selección secundaria, bordes
  bg3 = "#4a3a57", -- guías de indentación
  bg_float = "#231f29", -- Fondo sólido para ventanas flotantes (necesario para legibilidad)

  -- Primer plano: texto
  fg0 = "#e6e1eb", -- texto principal
  fg1 = "#c0b7cf", -- texto secundario (Docs, Parámetros TS)
  fg2 = "#a59ab3", -- texto terciario (Comentarios normales, Números de línea)
  fg3 = "#7a6d8a", -- texto muy tenue (Invisibles)

  -- Púrpura (Color de acento principal)
  purple0 = "#6f4683", -- púrpura oscuro (Selección Visual)
  purple1 = "#886593", -- púrpura medio (Operadores TS)
  purple2 = "#b58ac6", -- púrpura claro (Títulos, Estructuras)
  purple3 = "#d3b0e0", -- púrpura muy claro (Resaltados)

  -- Rojo (Errores, Keywords)
  red = "#e23e64",
  red_light = "#f05a7a", -- Errores LSP
  red_dark = "#b12b4b", -- Diff Delete

  -- Naranja (Constantes, Atributos)
  orange = "#e69d25",
  orange_light = "#f0b34b", -- Números

  -- Amarillo (Strings)
  yellow = "#f2d16b",
  yellow_light = "#fae29c",

  -- Verde (Añadidos, Success)
  green = "#7ec8a6",
  green_light = "#9edbbc", -- Diff Add

  -- Cian (Tipos, Builtins)
  cyan = "#4fb3a5",
  cyan_light = "#70cfc0",

  -- Azul (Funciones)
  blue = "#5fafd7",
  blue_light = "#81c4e6",
}

-- Configuración inicial
vim.opt.termguicolors = true
if vim.g.colors_name then
  vim.cmd("hi clear")
end
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "obsidian_master"

local hl = function(group, settings)
  vim.api.nvim_set_hl(0, group, settings)
end

-- =============================================================================
-- EDITOR / INTERFAZ BÁSICA (Implementación de Transparencia)
-- =============================================================================
-- bg = "NONE" permite que la transparencia de la terminal funcione.

hl("Normal", { fg = colors.fg0, bg = "NONE" })
hl("NormalNC", { fg = colors.fg0, bg = "NONE" }) -- ventanas no activas
hl("SignColumn", { bg = "NONE" }) -- Columna de GitGutter/LSP
hl("EndOfBuffer", { fg = colors.bg0, bg = "NONE" }) -- Tildes ~ invisibles
hl("LineNr", { fg = colors.bg3, bg = "NONE" }) -- Números de línea normales
hl("Folded", { fg = colors.purple1, bg = "NONE", italic = true }) -- Código plegado

-- Elementos de UI sobre el fondo transparente
hl("CursorLine", { bg = colors.bg1 }) -- Resaltado de línea actual
hl("CursorLineNr", { fg = colors.purple3, bg = colors.bg1, bold = true })
hl("Cursor", { fg = colors.bg0, bg = colors.purple2 })
hl("TermCursor", { fg = colors.bg0, bg = colors.purple2 })

-- Ventanas Flotantes y Menús (Requieren fondo sólido para legibilidad)
hl("NormalFloat", { fg = colors.fg0, bg = colors.bg_float })
hl("FloatBorder", { fg = colors.purple2, bg = colors.bg_float })
hl("Pmenu", { fg = colors.fg0, bg = colors.bg_float }) -- Menú autocompletado
hl("PmenuSel", { fg = colors.bg0, bg = colors.purple2, bold = true })
hl("PmenuSbar", { bg = colors.bg2 })
hl("PmenuThumb", { bg = colors.purple1 })

-- Selección y Búsqueda (Mejorado el contraste)
hl("Visual", { bg = colors.purple0 }) -- Púrpura oscuro para selección
hl("VisualNOS", { bg = colors.purple0 })
hl("Search", { fg = colors.bg0, bg = colors.yellow })
hl("IncSearch", { fg = colors.bg0, bg = colors.orange })

-- Otros elementos de UI
hl("ColorColumn", { bg = colors.bg1 })
hl("MatchParen", { fg = colors.purple3, bg = colors.bg2, bold = true })
hl("NonText", { fg = colors.bg3 }) -- Caracteres invisibles
hl("Whitespace", { fg = colors.bg3 })
hl("VertSplit", { fg = colors.bg2, bg = "NONE" }) -- Separador de ventanas
hl("Title", { fg = colors.purple2, bold = true })
hl("ErrorMsg", { fg = colors.red_light, bold = true })
hl("WarningMsg", { fg = colors.orange })

-- =============================================================================
-- SINTAXIS BÁSICA (Vim heredado y fallback)
-- =============================================================================
hl("Comment", { fg = colors.fg2, italic = true }) -- Más tenue
hl("SpecialComment", { fg = colors.fg1, italic = true })
hl("Constant", { fg = colors.orange })
hl("String", { fg = colors.yellow })
hl("Character", { fg = colors.yellow_light })
hl("Number", { fg = colors.orange_light })
hl("Boolean", { fg = colors.orange, bold = true })
hl("Float", { fg = colors.orange_light })
hl("Identifier", { fg = colors.fg0 }) -- Variables por defecto
hl("Function", { fg = colors.blue, bold = true })
hl("Statement", { fg = colors.red })
hl("Conditional", { fg = colors.red, italic = true })
hl("Repeat", { fg = colors.red, bold = true })
hl("Label", { fg = colors.red })
hl("Operator", { fg = colors.purple1 })
hl("Keyword", { fg = colors.red, italic = true })
hl("Exception", { fg = colors.red_light, bold = true })
hl("PreProc", { fg = colors.purple1 })
hl("Include", { fg = colors.purple1 })
hl("Define", { fg = colors.purple1 })
hl("Macro", { fg = colors.purple2 })
hl("Type", { fg = colors.cyan })
hl("StorageClass", { fg = colors.cyan, italic = true })
hl("Structure", { fg = colors.cyan })
hl("Typedef", { fg = colors.cyan })
hl("Special", { fg = colors.purple2 })
hl("Delimiter", { fg = colors.fg2 })
hl("Underlined", { underline = true })
hl("Error", { fg = colors.red_light, bg = "NONE", bold = true })
hl("Todo", { fg = colors.bg0, bg = colors.yellow, bold = true })

-- =============================================================================
-- TREESITTER (Mejorado y ajustado)
-- =============================================================================
-- Comentarios TS
hl("@comment", { fg = colors.fg2, italic = true }) -- Comentario normal tenue
hl("@comment.documentation", { fg = colors.fg1 }) -- Docstrings más brillantes

-- Variables
hl("@variable", { fg = colors.fg0 })
hl("@variable.builtin", { fg = colors.purple1, italic = true })
hl("@variable.parameter", { fg = colors.fg1 }) -- Parámetros ligeramente distintos
hl("@variable.member", { fg = colors.cyan_light })

-- Funciones y Métodos
hl("@function", { fg = colors.blue, bold = true })
hl("@function.call", { fg = colors.blue })
hl("@function.builtin", { fg = colors.blue_light })
hl("@method", { fg = colors.blue })
hl("@constructor", { fg = colors.purple2 })

-- Keywords
hl("@keyword", { fg = colors.red, italic = true })
hl("@keyword.function", { fg = colors.red, italic = true })
hl("@keyword.return", { fg = colors.red, italic = true, bold = true })
hl("@keyword.operator", { fg = colors.purple1 })

-- Literales y Tipos
hl("@string", { fg = colors.yellow })
hl("@string.escape", { fg = colors.purple2 })
hl("@type", { fg = colors.cyan })
hl("@type.builtin", { fg = colors.cyan_light })
hl("@constant", { fg = colors.orange })
hl("@constant.builtin", { fg = colors.orange_light })

-- Puntuación
hl("@punctuation.delimiter", { fg = colors.fg2 })
hl("@punctuation.bracket", { fg = colors.fg2 })

-- =============================================================================
-- LSP (Diagnósticos y UI)
-- =============================================================================
hl("DiagnosticError", { fg = colors.red_light })
hl("DiagnosticWarn", { fg = colors.orange })
hl("DiagnosticInfo", { fg = colors.blue })
hl("DiagnosticHint", { fg = colors.cyan })

-- Subrayados ondulados (Undercurl) para errores
hl("DiagnosticUnderlineError", { undercurl = true, sp = colors.red_light })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = colors.orange })

-- Referencias (resaltado de palabra bajo cursor)
hl("LspReferenceText", { bg = colors.bg2 })
hl("LspReferenceRead", { bg = colors.bg2 })
hl("LspReferenceWrite", { bg = colors.bg2 })

-- =============================================================================
-- PLUGINS
-- =============================================================================

-- Git Signs
hl("GitSignsAdd", { fg = colors.green })
hl("GitSignsChange", { fg = colors.orange })
hl("GitSignsDelete", { fg = colors.red_light })

-- Telescope (Manteniendo fondos sólidos para UI limpia)
hl("TelescopeBorder", { fg = colors.purple2, bg = colors.bg_float })
hl("TelescopeNormal", { bg = colors.bg_float })
hl("TelescopePromptNormal", { bg = colors.bg1 })
hl("TelescopePromptBorder", { fg = colors.purple2, bg = colors.bg1 })
hl("TelescopePromptTitle", { fg = colors.bg0, bg = colors.purple2, bold = true })
hl("TelescopeSelection", { bg = colors.bg2 })
hl("TelescopeMatching", { fg = colors.yellow, bold = true })

-- Neo-tree (Sutilmente oscuro, no totalmente transparente para separar)
hl("NeoTreeNormal", { bg = colors.bg_float })
hl("NeoTreeNormalNC", { bg = colors.bg_float })
hl("NeoTreeVertSplit", { fg = colors.bg0, bg = colors.bg0 })
hl("NeoTreeDirectoryIcon", { fg = colors.purple2 })
hl("NeoTreeDirectoryName", { fg = colors.purple2 })
hl("NeoTreeFileName", { fg = colors.fg0 })
hl("NeoTreeGitAdded", { fg = colors.green })
hl("NeoTreeGitModified", { fg = colors.orange })
hl("NeoTreeGitDeleted", { fg = colors.red_light })

-- Bufferline
hl("BufferlineFill", { bg = "NONE" }) -- Fondo transparente detrás de pestañas
hl("BufferlineBackground", { bg = colors.bg1, fg = colors.fg2 })
hl("BufferlineBufferSelected", { bg = "NONE", fg = colors.purple2, bold = true })
hl("BufferlineSeparator", { fg = colors.bg0, bg = colors.bg1 })
hl("BufferlineIndicatorSelected", { fg = colors.purple2 })

-- Indent Blankline
hl("IblIndent", { fg = colors.bg3 })
hl("IblScope", { fg = colors.purple1 })

-- =============================================================================
-- STATUSLINE
-- =============================================================================
hl("StatusLine", { fg = colors.fg0, bg = colors.bg2 })
hl("StatusLineNC", { fg = colors.fg2, bg = colors.bg1 })

-- =============================================================================
-- FIN DEL TEMA
-- =============================================================================
