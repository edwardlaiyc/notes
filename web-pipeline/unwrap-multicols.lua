-- Cheatsheets wrap their whole body in \begin{multicols}{N}. Pandoc turns that
-- into a Div, and TOC generation only collects TOP-LEVEL headings — so every
-- heading inside the Div silently vanishes from the TOC (and the sidebar card
-- disappears entirely, since the template keys off $if(toc)$).
-- Unwrap the Div so the headings sit at top level. Print columns are also the
-- wrong model for the web: single-column reflow is what we want anyway.
function Div(d)
  if d.classes:includes("multicols") then
    local blocks = d.content
    -- \begin{multicols}{2} leaves the column count behind as a stray "2" para
    if blocks[1] and blocks[1].t == "Para" then
      if pandoc.utils.stringify(blocks[1]):match("^%s*%d+%s*$") then
        table.remove(blocks, 1)
      end
    end
    return blocks
  end
end
