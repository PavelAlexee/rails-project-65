# frozen_string_literal: true

CATEGORYS = %w[Электроника Книги Мебель Одежда]

CATEGORYS.each do |categoty|
  Category.create(name: categoty)
end
