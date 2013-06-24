class Pytanie < ActiveRecord::Base
    self.table_name = 'pytanie'
    self.primary_key = :id_pyt

    has_many :odpowiedzi, :foreign_key => 'id_pyt', :class_name => "OdpowiedzWzorcowa"
    belongs_to :typ, :foreign_key => 'id_typu', :class_name => "Typ"
    belongs_to :quiz, :class_name => "Quiz"
    belongs_to :kategoria, :class_name => "Kategoria"

    attr_accessible :id_quizu, :tresc, :id_kategorii, :pkt, :id_typu, :id_autora, :id_pyt

    accepts_nested_attributes_for :odpowiedzi

  def r_odpowiedzi
    result = []
    result += odpowiedzi.shuffle[0..(typ.liczba_odp-1)]
    if result.index{ |odpowiedz| odpowiedz.poziom_poprawnosci==100 }.nil?
      result[0] = odpowiedzi[odpowiedzi.index { |odpowiedz| odpowiedz.poziom_poprawnosci == 100 } ]
    end

    result
  end

  def otwarte?
    typ.liczba_odp==1
  end

  def wielokrotnego_wyboru?
    typ.wielokrotnego_wyboru
  end
end
