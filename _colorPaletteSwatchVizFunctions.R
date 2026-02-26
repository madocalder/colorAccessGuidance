# CSS for the color palettes (include this once in your Quarto document)
get_palette_css <- function() {
  return('
/* CVD Controls */
.cvd-controls {
  margin: 1rem 0;
  padding: 1rem;
  background: #f8f9fa;
  border-radius: 8px;
  border: 1px solid #e9ecef;
}

.vision-mode legend {
  font-weight: bold;
  margin-bottom: 0.5rem;
  color: #333;
}

.control-group {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
}

.vision-mode input[type="radio"] {
  margin-right: 0.25rem;
}

.vision-mode label {
  cursor: pointer;
  padding: 0.25rem 0.5rem;
  border-radius: 4px;
  transition: background-color 0.2s ease;
}

.vision-mode label:hover {
  background-color: #e9ecef;
}

.vision-mode input[type="radio"]:checked + label {
  background-color: #007bff;
  color: white;
}

/* Palette Container - HORIZONTAL LAYOUT */
.palette-container {
  display: flex;
  flex-direction: row;
  flex-wrap: nowrap;
  justify-content: flex-start;
  align-items: stretch;
  gap: 1rem;
  padding: 1rem;
  background: #f8f9fa;
  border-radius: 8px;
  margin: 1rem 0;
  overflow-x: auto;
  min-height: 200px;
}

/* Individual Color Swatch */
.color-swatch {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin: 0;
  flex: 1;
  min-width: 120px;
  max-width: 150px;
}

/* Color Square */
.swatch {
  position: relative;
  width: 100%;
  aspect-ratio: 1;
  border: 2px solid #e9ecef;
  border-radius: 4px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  transition: transform 0.2s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.swatch:hover {
  transform: scale(1.05);
}

.color-name {
  font-size: 0.75rem;
  font-weight: bold;
  background: rgba(255,255,255,0.9);
  padding: 0.125rem 0.25rem;
  border-radius: 2px;
}

.swatch[style*="color: white"] .color-name {
  background: rgba(0,0,0,0.7);
  color: white;
}

.swatch[style*="color: black"] .color-name {
  background: rgba(255,255,255,0.9);
  color: black;
}

/* Swatch Information */
.swatch-info {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 0.5rem;
  text-align: center;
  font-size: 0.75rem;
  width: 100%;
}

.hex-code {
  font-family: "Monaco", "Menlo", "Ubuntu Mono", monospace;
  font-weight: bold;
  color: #333;
  margin-bottom: 0.25rem;
  word-break: break-all;
}

.contrast-info {
  display: flex;
  justify-content: space-between;
  gap: 0.25rem;
  margin-bottom: 0.5rem;
  width: 100%;
}

.contrast-white,
.contrast-black {
  font-size: 0.7rem;
  color: #666;
  flex: 1;
}

.accessibility {
  display: flex;
  justify-content: space-between;
  gap: 0.25rem;
  margin-bottom: 0.5rem;
  width: 100%;
}

.w3c-aa,
.w3c-aaa,
.apca-bronze {
  padding: 0.125rem 0.25rem;
  border-radius: 2px;
  font-size: 0.625rem;
  font-weight: bold;
  text-transform: uppercase;
  flex: 1;
  text-align: center;
}

.w3c-aa.pass,
.w3c-aaa.pass,
.apca-bronze.pass {
  background-color: #28a745;
  color: white;
}

.w3c-aa.fail,
.w3c-aaa.fail,
.apca-bronze.fail {
  background-color: #dc3545;
  color: white;
}

/* Multiple palettes layout */
.multi-palette-container {
  display: flex;
  flex-direction: column;
  gap: 2rem;
  margin: 2rem 0;
}

.palette-section {
  border: 1px solid #e9ecef;
  border-radius: 8px;
  padding: 1rem;
  background: white;
}

.palette-section h3 {
  margin-top: 0;
  color: #333;
  border-bottom: 2px solid #f8f9fa;
  padding-bottom: 0.5rem;
}

/* Responsive adjustments */
@media (max-width: 1200px) {
  .palette-container {
    flex-wrap: wrap;
    justify-content: center;
  }

  .color-swatch {
    flex: 0 1 calc(25% - 1rem);
    min-width: 100px;
  }
}

@media (max-width: 768px) {
  .control-group {
    flex-direction: column;
    gap: 0.5rem;
  }

  .color-swatch {
    flex: 0 1 calc(33.333% - 1rem);
  }
}

@media (max-width: 480px) {
  .color-swatch {
    flex: 0 1 calc(50% - 0.5rem);
  }
}
')
}

# JavaScript for CVD toggles (include this once)
get_palette_js <- function() {
  return('
<script>
document.addEventListener("DOMContentLoaded", function() {
  const visionControls = document.querySelectorAll(\'input[name="vision-mode"]\');

  function updateColorVision(mode) {
    const colorSwatches = document.querySelectorAll(\'.color-swatch\');

    colorSwatches.forEach(swatch => {
      const swatchDiv = swatch.querySelector(\'.swatch\');
      const hexCode = swatch.querySelector(\'.hex-code\');

      if (mode === "normal") {
        const normalColor = swatchDiv.getAttribute("data-normal");
        swatchDiv.style.backgroundColor = normalColor;
        hexCode.textContent = normalColor;
      } else {
        const simulatedColor = swatchDiv.getAttribute(`data-${mode}`);
        swatchDiv.style.backgroundColor = simulatedColor;
        hexCode.textContent = simulatedColor;
      }
    });
  }

  // Add event listeners to radio buttons
  visionControls.forEach(control => {
    control.addEventListener("change", function() {
      if (this.checked) {
        updateColorVision(this.value);
      }
    });
  });

  // Initialize with normal vision
  updateColorVision("normal");
});
</script>
')
}

# Function to generate a single palette
generate_single_palette <- function(color_properties, contrast_matrix, palette_name = NULL) {

  if (is.null(palette_name)) {
    palette_name <- unique(color_properties$palette_name)[1]
  }

  # Start building HTML for one palette
  html <- sprintf('
  <div class="palette-section">
    <h3>%s</h3>
    <div class="palette-container">', palette_name)

  # Add each color swatch
  for(i in 1:nrow(color_properties)) {
    color <- color_properties[i, ]

    # Get contrast information (against white)
    contrast_white <- contrast_matrix[
      contrast_matrix$color1 == color$color_id &
        contrast_matrix$color2 == "white",
    ]

    # Get contrast information (against black)
    contrast_black <- contrast_matrix[
      contrast_matrix$color1 == color$color_id &
        contrast_matrix$color2 == "black",
    ]

    # Choose text color based on better contrast
    text_color <- ifelse(
      contrast_white$w3c_contrast > contrast_black$w3c_contrast,
      "white", "black"
    )

    swatch_html <- sprintf('
    <figure class="color-swatch" data-color-id="%s">
      <div class="swatch"
           style="background-color: %s; color: %s;"
           data-normal="%s"
           data-deuteranopia="%s"
           data-protanopia="%s"
           data-tritanopia="%s"
           data-desat_50="%s"
           data-desat_100="%s">
        <span class="color-name">%s</span>
      </div>
      <figcaption class="swatch-info">
        <span class="hex-code">%s</span>
        <div class="contrast-info">
          <span class="contrast-white">W:%.1f</span>
          <span class="contrast-black">B:%.1f</span>
        </div>
        <div class="accessibility">
          <span class="w3c-aa %s" title="WCAG AA">AA</span>
          <span class="w3c-aaa %s" title="WCAG AAA">AAA</span>
          <span class="apca-bronze %s" title="APCA Bronze">APCA</span>
        </div>
      </figcaption>
    </figure>',
                           color$color_id,
                           color$hex_code, text_color, color$hex_code,
                           color$deuteranopia_hex, color$protanopia_hex, color$tritanopia_hex,
                           color$desat_50_hex, color$desat_100_hex,
                           color$color_id, color$hex_code,
                           contrast_white$w3c_contrast, contrast_black$w3c_contrast,
                           ifelse(contrast_white$w3c_pass_AA, "pass", "fail"),
                           ifelse(contrast_white$w3c_pass_AAA, "pass", "fail"),
                           ifelse(contrast_white$apca_bronze_Lc60, "pass", "fail")
    )

    html <- paste0(html, swatch_html)
  }

  html <- paste0(html, '
    </div>
  </div>')

  return(html)
}

# Function to generate multiple palettes with global controls
generate_multiple_palettes <- function(palettes_list) {
  # palettes_list should be a list where each element is a list with:
  # - color_properties
  # - contrast_matrix
  # - palette_name (optional, will use from data if not provided)

  html <- '
<div class="multi-palette-container">
  <div class="cvd-controls">
    <fieldset class="vision-mode">
      <legend>Color Vision Simulation (Applies to All Palettes)</legend>
      <div class="control-group">
        <input type="radio" id="vision-normal" name="vision-mode" value="normal" checked>
        <label for="vision-normal">Normal Vision</label>

        <input type="radio" id="vision-deuteranopia" name="vision-mode" value="deuteranopia">
        <label for="vision-deuteranopia">Deuteranopia</label>

        <input type="radio" id="vision-protanopia" name="vision-mode" value="protanopia">
        <label for="vision-protanopia">Protanopia</label>

        <input type="radio" id="vision-tritanopia" name="vision-mode" value="tritanopia">
        <label for="vision-tritanopia">Tritanopia</label>

        <input type="radio" id="vision-desat50" name="vision-mode" value="desat_50">
        <label for="vision-desat50">50% Desaturated</label>

        <input type="radio" id="vision-desat100" name="vision-mode" value="desat_100">
        <label for="vision-desat100">Full Desaturation</label>
      </div>
    </fieldset>
  </div>'

  # Add each palette
  for(i in seq_along(palettes_list)) {
    palette <- palettes_list[[i]]

    palette_name <- if (!is.null(palette$palette_name)) {
      palette$palette_name
    } else if (!is.null(palette$color_properties$palette_name)) {
      unique(palette$color_properties$palette_name)[1]
    } else {
      paste("Palette", i)
    }

    html <- paste0(html, generate_single_palette(
      palette$color_properties,
      palette$contrast_matrix,
      palette_name
    ))
  }

  html <- paste0(html, '</div>')

  return(html)
}
