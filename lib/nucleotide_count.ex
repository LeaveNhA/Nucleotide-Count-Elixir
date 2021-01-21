defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  def count([], _) do
    0
  end

  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    NucleotideCount.histogram(strand)
    # --------nucleotides, default
    |> Map.get(nucleotide, 0)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do
    strand
    |> Enum.frequencies
    |> Map.merge(
      @nucleotides
      |> Enum.map(fn n -> {n, 0} end)
      |> Map.new,
      fn (_, v, vv) -> v + vv end)
  end
end
