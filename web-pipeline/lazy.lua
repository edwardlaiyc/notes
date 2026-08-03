local stringify = pandoc.utils.stringify

-- Lazy-load + async-decode every image
function Image(el)
  el.attributes['loading'] = 'lazy'
  el.attributes['decoding'] = 'async'
  return el
end

-- Wrap tables in a scroll container so wide tables never overflow on mobile
function Table(el)
  return pandoc.Div({el}, pandoc.Attr('', {'table-wrap'}))
end

-- Remove the duplicated outer caption pandoc copies onto an (originally
-- uncaptioned) figure that groups sub-figures: if the outer figure's caption
-- is identical to its last inner sub-figure's caption, blank the outer one.
function Figure(fig)
  local inners = {}
  pandoc.walk_block(pandoc.Div(fig.content), {
    Figure = function(f) inners[#inners + 1] = f end
  })
  if #inners > 0 then
    local outer = stringify(fig.caption.long)
    local last  = stringify(inners[#inners].caption.long)
    if outer ~= '' and outer == last then
      fig.caption = pandoc.Caption({})
    end
  end
  return fig
end
