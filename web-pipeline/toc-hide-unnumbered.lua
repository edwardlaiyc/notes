-- Match the PDF's table of contents.
--
-- In LaTeX, *starred* sectioning commands (\section*, \subsection*,
-- \subsubsection*, ...) are deliberately NOT written to the .toc file, so the
-- PDF's Contents lists only the numbered headings. Pandoc, by contrast, puts
-- EVERY heading in the web Contents. Because a starred sub-step (e.g.
-- "Numerical Calculation") is authored at the same heading level as the
-- numbered heading it belongs under (e.g. "3.5.3 The posterior parameters"),
-- it renders in the ToC at the same indentation -- a flat, confusing list.
--
-- Pandoc tags starred headings with the `unnumbered` class. Adding `unlisted`
-- makes pandoc drop the heading from the table of contents while still
-- rendering it in the page body -- so the web Contents mirrors the PDF's.
function Header(el)
  if el.classes:includes('unnumbered') and not el.classes:includes('unlisted') then
    el.classes:insert('unlisted')
  end
  return el
end
