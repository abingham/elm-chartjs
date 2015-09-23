module Chartjs.Bar
  ( chart, chart'
  , Options, defaultOptions
  , Series, Config
  , Style, defStyle, defaultStyle
  ) where

import Color exposing (white, rgba, Color)
import Chartjs exposing (Label, JSArray, Labels, toArray, showRGBA)
import Graphics.Element exposing (Element)
import Native.Chartjs

type alias Style =
  { fillColor: Color
  , strokeColor: Color
  , highlightFill: Color
  , highlightStroke: Color }

defStyle : (Float -> Color) -> Style
defStyle f =
  { fillColor = f 0.5
  , strokeColor = f 0.8
  , highlightFill = f 0.75
  , highlightStroke = f 1.0 }

defaultStyle : Style
defaultStyle = defStyle (rgba 220 220 220)

type alias Series = (Label, Style, List Float)

type alias Config = (Labels, List Series)

type alias ConfigRaw =
  { labels : JSArray String
     , datasets : JSArray
      { label : String
      , fillColor : String
      , strokeColor : String
      , highlightFill : String
      , highlightStroke : String
      , data : JSArray Float } }

type alias Options =
  { scaleBeginAtZero : Bool
  , scaleShowGridLines : Bool
  , scaleGridLineColor : Color
  , scaleGridLineWidth : Float
  , scaleShowHorizontalLines: Bool
  , scaleShowVerticalLines: Bool
  , barShowStroke : Bool
  , barStrokeWidth : Float
  , barValueSpacing : Float
  , barDatasetSpacing : Float
  , legendTemplate : String }

type alias OptionsRaw =
  { scaleBeginAtZero : Bool
  , scaleShowGridLines : Bool
  , scaleGridLineColor : String
  , scaleGridLineWidth : Float
  , scaleShowHorizontalLines: Bool
  , scaleShowVerticalLines: Bool
  , barShowStroke : Bool
  , barStrokeWidth : Float
  , barValueSpacing : Float
  , barDatasetSpacing : Float
  , legendTemplate : String }

defaultOptions : Options
defaultOptions =
  { scaleBeginAtZero = True
  , scaleShowGridLines = True
  , scaleGridLineColor = rgba 0 0 0 0.05
  , scaleGridLineWidth = 1.0
  , scaleShowHorizontalLines = True
  , scaleShowVerticalLines = True
  , barShowStroke = True
  , barStrokeWidth = 2.0
  , barValueSpacing = 5.0
  , barDatasetSpacing = 1.0
  , legendTemplate = "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].fillColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>" }

chartRaw : Int -> Int -> ConfigRaw -> OptionsRaw -> Element
chartRaw = Native.Chartjs.lineChartRaw

chart : Int -> Int -> Config -> Options -> Element
chart w h c o = chartRaw w h (decodeConfig c) (decodeOptions o)

{-| Same as `chart` but default options are assumed -}
chart' : Int -> Int -> Config -> Element
chart' w h c = chart w h c defaultOptions