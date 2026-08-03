--[[ qa-details.lua — turn answered list items into click-to-reveal dropdowns.

A question page authors each answer as an `answer` environment tucked inside the
list item, right after the question (and its options, if any):

    \item Some claim. TRUE or FALSE?
    \begin{answer}FALSE --- because ...\end{answer}

Pandoc reads the undefined environment as a `Div` of class `answer`. This filter
rewrites any list item carrying such a Div into a native HTML <details>
disclosure: the question and any options become the <summary> (the whole thing
is the click target), and the answer becomes the collapsible body. A CSS-drawn
caret is appended to the stem so the question reads as clickable, flipping when
open. No JavaScript, and the markup degrades to a plain list where unstyled.

The filter is inert on any list item without an `answer` Div, so it is safe to
run on every course build, not just the question pages.
]]

local function item_has_answer(item)
  for _, blk in ipairs(item) do
    if blk.t == "Div" and blk.classes:includes("answer") then
      return true
    end
  end
  return false
end

local function transform_item(item)
  local pre = {}          -- question stem + any options, before the answer
  local answer = nil      -- the answer's blocks
  for _, blk in ipairs(item) do
    if answer == nil and blk.t == "Div" and blk.classes:includes("answer") then
      answer = blk.content
    elseif answer == nil then
      pre[#pre + 1] = blk
    end
    -- Anything after the answer Div is unexpected; drop it.
  end
  if answer == nil then return item end

  -- Signal clickability: append a caret to the end of the stem line.
  local stem = pre[1]
  if stem and (stem.t == "Para" or stem.t == "Plain") then
    stem.content:insert(pandoc.Space())
    stem.content:insert(
      pandoc.RawInline("html", '<span class="qa-caret" aria-hidden="true"></span>'))
  end

  local out = pandoc.List()
  out:insert(pandoc.RawBlock("html", '<details class="qa">'))
  out:insert(pandoc.RawBlock("html", "<summary>"))
  for _, blk in ipairs(pre) do out:insert(blk) end
  out:insert(pandoc.RawBlock("html", "</summary>"))
  out:insert(pandoc.Div(answer, pandoc.Attr("", { "qa-answer" }, {})))
  out:insert(pandoc.RawBlock("html", "</details>"))
  return out
end

local function process_list(el)
  local changed = false
  for i, item in ipairs(el.content) do
    if item_has_answer(item) then
      el.content[i] = transform_item(item)
      changed = true
    end
  end
  if changed then return el end
end

return {
  { OrderedList = process_list, BulletList = process_list },
}
