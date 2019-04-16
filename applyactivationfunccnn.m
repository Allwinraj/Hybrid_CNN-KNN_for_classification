function a=applyactivationfunccnn(z, act_func, dir, err)
%%%% ALLWINRAJ A %%%%%%%%%%
if dir==1000
    a=ones(size(z));
else
if act_func=='sigm'
    a=1./(1+exp(-z));
    if dir ==1
        a = z.* (1-z);
        a = a.*err;
    end
elseif act_func == 'tanh'
      a = tanh(z);
      if dir ==1
          a = 1-z.*z;
          a = a.*err;
      end
elseif act_func == 'rect' %ReLU
    leak = 0.01;
      a = z .* (leak + (1 - leak) * (z > 0)) ;
      if dir ==1
          a = (leak + (1 - leak) * (z > 0)) ;
          a= a.*err;
      end 
elseif act_func == 'none'
    a=z;
    if dir ==1
        a = z.*err;
    end
elseif act_func == 'soft' %softmax
    a= exp(z);
    a = (a)./repmat(sum(a,1), [size(z,1) 1]);
    if dir ==1

        err1 = repmat(sum(err.*z, 1), [size(err,1) 1]);
        a = -z.* (err1 -err);
    end
elseif act_func == 'plus'  %softplus - similar to ReLu (rect)
    checkvalues(z)
    a = log(1+exp(z));
    checkvalues(a, z)
    if dir==1
         a=1 - exp(-z);
         a = a.*err;
    end
else
    error 'activation function not implemented'
end

end