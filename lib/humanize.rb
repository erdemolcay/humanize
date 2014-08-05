require "humanize/configuration"
require "humanize/languages"

module Humanize

  def humanize
    [int_to_words(self.to_i), language[:separator], int_to_words(self.decimal)].join
  end

  def decimal(rounding = default_rounding)
    self.to_s.split(".", 2).last.split(//).first(rounding).join.ljust(rounding, "0").to_i
  end

  def int_to_words(num)
    o = ''
    if num < 0
      o += 'negative '
      num = num.abs
    end
    if num.zero?
      o += 'zero'
    else
      sets = []
      i = 0
      f = false
      while !num.zero?
        num, r = num.divmod(1000)
        sets << language[:up_one_thousand][i] + (!sets.empty? ? (f ? ' and' : ',') : '') if !(r.zero? || i.zero?)
        f = true if i.zero? && r < 100
        sets << language[:sub_one_thousand][r] if !r.zero?
        i = i.succ
      end
      o += sets.reverse.join(' ')
    end
  end

  private

  def language
    Humanize::Languages.send(Humanize.conf.language)
  end

  def default_rounding
    Humanize.conf.rounding
  end

end

class Numeric
  include Humanize
end
