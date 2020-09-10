function vcf_tbl = vcf2table(vcf_in)

    if contains(vcf_in, ".gz")
        gunzip(vcf_in)
        vcf_in = extractBefore(vcf_in,".gz");
    end

    fid_in = fopen(vcf_in, 'r');
    fid_out = fopen("tmp.txt", 'w+');
    last_line = "";
    header_flag = 0;
    
    if fid_in == -1
        error("Could not read input VCF file!")
    end
    
    while true
        
        line = fgetl(fid_in);
        
        if ~ischar(line)
            break
        elseif line(1) == "#"
            last_line = line;
            continue
        else
            if ~header_flag
                fprintf(fid_out, last_line+"\n");
                header_flag = 1;
            end
            
            fprintf(fid_out, line+"\n");
        end
        
    end
    
    fclose(fid_in);
    fclose(fid_out);
    
    fid_tmp = fopen("tmp.txt", 'r');
    
    header_flag = 0;
    header = "";
    new_table_header = {};
    new_table_data = [];
    
    while true
        
        line = fgetl(fid_tmp);
        
        if ~header_flag
            header = split(line, "	");
            header_flag = 1;
            continue
        elseif ~ischar(line)
           break
        end
        
        line_split = split(line, "	");
        
        genome_start_ind = find(header == "FORMAT")+1;
        
        curr_pos = line_split(header == "POS");
        curr_genomes = line_split(genome_start_ind:end);
        new_table_header(end+1) = cellstr("Pos" + curr_pos{1});
        
        new_table_data = [new_table_data, contains(curr_genomes, "1/1")];
        
    end
    
    [unique_headers, unique_ind, ~] = unique(new_table_header);
    unique_data = new_table_data(:, unique_ind);
    genomes = header(genome_start_ind:end);
    
    vcf_tbl = array2table(unique_data,...
        'VariableNames', unique_headers,...
        'RowNames', genomes);
    vcf_tbl.strain_ID = genomes;
    vcf_tbl = [vcf_tbl(:,end),vcf_tbl(:,1:end-1)];
    
    delete('tmp.txt');
    
end