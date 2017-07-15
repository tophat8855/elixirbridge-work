defmodule Calc do
  @moduledoc """
  My Calculator
  """

  @doc """
  Add two numbers together

  Example
    Calc.add(1, 2)  #3
    Calc.add(4)     #4
  """
  def add(a, b \\ 1) when is_integer(a) and is_integer(b) do
    a + b
  end

  def subtract(b, a) do
    b - a
  end

  def double(a) do
    a + a
  end

  def divide(b, a) do
    b / a
  end

  def zero?(0), do: true
  def zero?(_), do: false

  defmacro __using__(_) do
    quote do
    end
  end
end
