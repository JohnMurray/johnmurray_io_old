class PrettifierHelper
  class <<self

    def get_scripts(lang_array)
      @LANG_EXTRAS ||= [
        'apollo',
        'clj',
        'css',
        'go',
        'hs',
        'lisp',
        'lua',
        'ml',
        'n',
        'proto',
        'scala',
        'sql',
        'tex',
        'vb',
        'vhdl',
        'wiki',
        'xq',
        'yaml'
      ]
      @js = []
      @js << 'prettify.js'
      lang_array.each do |lang|
        @js << "lang-#{lang}.js" if @LANG_EXTRAS.include? lang.downcase
      end
      @js
    end

  end
end
