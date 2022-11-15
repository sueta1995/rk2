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
    temp = checking

    # unless temp[:result].nil?
    #   redirect_to(root_path,
    #               notice: "Найден посторонний символ на #{temp[:index] + 1} месте: #{temp[:result]}.") and return
    # end
    return if base_case(temp)

    # redirect_to(root_path, notice: 'Обнаружен минус без числа.') and return if @input.split(' ').include?('-')
    return if minus_case

    # redirect_to(root_path, notice: 'Введите непустую строку.') and return if @input.split(' ').empty?
    return if empty_case

    # @input.split(' ').each do |x|
    #   redirect_to(root_path, notice: 'Обнаружены посторонние символы.') and return if x.length != x.to_i.to_s.length
    # end
    return if specific_case
  end

  def checking
    result = nil
    index = 0

    @input.split('').each_index do |i|
      unless @input[i] =~ /[-0-9 ]/
        (result = @input[i]
         index = i)
      end
    end

    { result:, index: }
  end

  def base_case(temp)
    return if temp[:result].nil?

    redirect_to(root_path,
                notice: "Найден посторонний символ на #{temp[:index] + 1} месте: #{temp[:result]}."); true
  end

  def minus_case
    return unless @input.split(' ').include?('-')

    redirect_to(root_path, notice: 'Обнаружен минус без числа.')
    true
  end

  def empty_case
    return unless @input.split(' ').empty?

    redirect_to(root_path, notice: 'Введите непустую строку.')
    true
  end

  def specific_case
    @input.split(' ').each do |x|
      next unless x.length != x.to_i.to_s.length

      redirect_to(root_path, notice: 'Обнаружены посторонние символы: лишние 0 или минус.')

      return true
    end
  end
end
