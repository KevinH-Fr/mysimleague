module TablesHelper
    # utilisé que en test dans synth licence
    def display_data_in_table(data, columns)
        if data && columns 
            content_tag(:table) do
                content_tag(:thead) do
                    content_tag(:tr) do
                        columns.map { |col| content_tag(:th, col) }.join.html_safe
                    end
                end +
                content_tag(:tbody) do
                    data.map do |row|
                        content_tag(:tr) do
                            row.map { |cell| content_tag(:td, cell) }.join.html_safe
                        end
                    end.join.html_safe
                end
            end
        end
    end
end