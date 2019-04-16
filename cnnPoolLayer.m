function cnn=cnnPoolLayer(cnn, subsamplerate, subsamplemethod)
%%%% ALLWINRAJ A %%%%%%%%%%
cnn.no_of_layers= cnn.no_of_layers +1;
l=cnn.no_of_layers;
cnn.layers{l}.type = 'p';
cnn.layers{l}.subsample_rate=subsamplerate;
cnn.layers{l}.subsample_method=subsamplemethod;
cnn.layers{l}.no_featuremaps = cnn.layers{l-1}.no_featuremaps;
cnn.layers{l}.featuremap_width = cnn.layers{l-1}.featuremap_width/subsamplerate;
cnn.layers{l}.featuremap_height = cnn.layers{l-1}.featuremap_height/subsamplerate;
    
cnn.layers{l}.act_func='none';
    
