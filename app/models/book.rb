# == Schema Information
#
# Table name: books
#
#  id         :integer          not null, primary key
#  state      :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Book < ApplicationRecord
  include AASM

  aasm column: :state do
    state :draft, initial: true
    state :verified
    state :rejected
    state :published

    # notificar a un autor cuando se realiza un cambio de estado y se pueden ejecutar en maquina de estado o callback

    # a nivel de transaccion
    after_all_transactions :after_transactions

    # a nivel de maquina de estado
    event :verify do
      # De - Para
      transitions from: :draft, to: :verified
    end

    event :verify do
      # De - Para
      transitions from: :draft, to: :verified
    end

    # validacion con el metodo guard, solo se ejecuta si la transicion es true
    event :reject, guard: :is_valid_reject? do
      # De - Para
      transitions from: :verified, to: :rejected
    end

    event :publicacion, after_transaction: :send_congratulations_mail do
      # De - Para
      transitions from: :rejected, to: :published
    end
  end

  def after_transactions
    puts "\nDespues de las transacciones"
  end

  def send_congratulations_mail
    puts "\nEstamos enviando un correo"
  end

  def is_valid_reject?
    true
  end
  
end
