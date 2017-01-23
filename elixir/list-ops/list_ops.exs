defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    l |> reduce(0, fn(_, acc) -> acc + 1 end)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    l |> reduce([], fn(val, acc) ->
      [ val | acc ]
    end)
  end


  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    l
    |> reduce([], fn(val,acc) -> [ f.(val) | acc ] end)
    |> reverse
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    l
    |> reduce([], fn(val,acc) ->
      if f.(val), do: [val | acc], else: acc
    end)
    |> reverse
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, f), do: acc

  def reduce([head|rest], acc, f) do
    rest
    |> reduce(f.(head, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    a |> reverse |> reduce(b, fn(val, acc) -> [ val | acc ] end)
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    ll |> reverse |> reduce([], &_concat/2)
  end

  defp _concat([h|t], acc), do: [ h | _concat(t, acc) ]
  defp _concat([], acc), do: acc
  defp _concat(v, acc), do: [ v | acc ]

end