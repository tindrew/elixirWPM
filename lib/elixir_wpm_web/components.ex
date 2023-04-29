defmodule ElixirWPMWeb.Components do
  use Phoenix.Component

  def link(assigns) do
    ~H"""
      <a href={@href} class="sm:px-6 test_class"><%= render_slot(@inner_block) %></a>
    """
  end
end
