-- slidebreak.lua
-- A Quarto shortcode that inserts a slide break in all slide deck formats
-- (revealjs, pptx/powerpoint, beamer) but does nothing in docx and html formats

function slidebreak()
  -- Get the current output format
  local format = quarto.doc.is_format
  
  -- Insert slide break for all slide/presentation formats
  -- The "slides" alias matches revealjs, pptx/powerpoint, beamer, and any future slide formats
  if format("slides") then
    -- Use HorizontalRule which creates a slide separator in presentation formats
    return pandoc.HorizontalRule()
  end
  
  -- Return empty for html and docx formats (and any other non-presentation format)
  return pandoc.Null()
end

-- Return the shortcode handler
return {
  ['slidebreak'] = slidebreak
}
