defmodule FarmWeb.CowView do
  use FarmWeb, :view

  def line_plot(data) do
    options = [
      stroke_width: 1,
      smoothed: false
    ]

    margins = %{left: 40, right: 15, top: 10, bottom: 20}

    data
    |> Dataset.new()
    |> Plot.new(LinePlot, 500, 150, options)
    |> Map.put(:margins, margins)
    |> Plot.to_svg()
  end
end
