let color = params[0];
if color.index_of("#") == 0 {
    return color.sub_string(1);
}
return color;
