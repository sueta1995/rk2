# frozen_string_literal: true

# controller class
class CalculatesController < ApplicationController
  before_action :set_input, only: [:create]
  before_action :valid?, only: [:create]

  def new; end

  def create
    @input_arr = @input.split(' ')

    # methods
  end

  private

  def set_input
    @input = params[:numbers]
  end

  def valid?
    result = nil
    index = 0

    @input.split('').each_index do |i|
      unless @input[i] =~ /[-0-9 ]/
        (result = @input[i]
         index = i)
      end
    end

    redirect_to(root_path, notice: "Найден посторонний символ на #{index + 1} месте: #{result}.") and return unless result.nil?
    redirect_to(root_path, notice: 'Обнаружен минус без числа.') and return if @input.split(' ').include?('-')
    redirect_to(root_path, notice: 'Введите непустую строку.') and return if @input.split(' ').empty?
  end
end
