defmodule BinaryTree do
  @doc """
    Build a binary search tree of input data
    ## Ex:
    iex > BinaryTree.build({1,2,3,4})
  """
  defstruct data: nil, left: nil, right: nil 

  @spec build(tuple) :: %BinaryTree{}
  def build(tuple) do
  end

  @spec find(%BinaryTree{}, any()) :: any()
  def find(tree, val) do
  end	
end

defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    numbers 
    |> BinaryTree.build
    |> BinaryTree.find(key)
  end
end
