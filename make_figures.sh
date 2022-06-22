# Render inkscape figures
# inkscape figures/sources/tanner_graph.svg --export-area-page --export-dpi 300 --export-type=pdf --export-filename figures/tanner_graph.pdf
# inkscape figures/sources/csp_commutation.svg --export-area-page --export-dpi 300 --export-type=pdf --export-filename figures/csp_commutation.pdf
for file in figures/vecto/*.svg; 
  do 
    inkscape $file --export-area-page --export-dpi 300 --export-type=pdf --export-filename "${file%.svg}.pdf" 
    mv "${file%.svg}.pdf" figures/
done

# Setup python environment
python -m venv figures/plots/venv
source figures/plots/venv/bin/activate
pip install numpy matplotlib seaborn

for file in figures/plots/*.py; 
  do 
    python $file "${file%.py}.pdf"
    mv "${file%.py}.pdf" figures/
done
