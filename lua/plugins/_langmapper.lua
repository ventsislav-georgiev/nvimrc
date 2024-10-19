return {
  'Wansmer/langmapper.nvim',
  lazy = false,
  priority = 1,
  config = function()
    local lm = require 'langmapper'
    local lma = require 'plugins._langmapper_auto'

    lm.auto = function()
      lma.global_automapping()
      lma.local_automapping()
    end

    lm.setup {
      hack_keymap = false,

      default_layout = [[±QWERTYUIOP{}ASDFGHJKL:"|~ZXCVBNM<>?§qwertyuiop[]asdfghjkl;'\`zxcvbnm,./]],
      use_layouts = { 'bg' },

      layouts = {
        bg = {
          id = 'com.apple.keylayout.Bulgarian-Phonetic',
          layout = [[±ЯВЕРТЪУИОПШЩАСДФГХЙКЛ:"ЮЧЗѝЦЖБНМ<>?§явертъуиопшщасдфгхйкл;'ючзьцжбнм,./]],
        },
      },
    }
  end,
}
