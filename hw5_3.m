imshow(ima3);
PSF = fspecial('motion',3,3); % blurrr
g_noise =  imnoise(zeros(size(ima3)), 'gaussian', 2, 0.001); % gaussian noise

Sn = abs(fft2(g_noise)) .^2; 

nA = sum(Sn(:))/numel(g_noise);
Sf = abs(fft2(ima3)) .^2;
fA = sum(Sf(:))/numel(ima3);
R = nA/fA;
fr2 = deconvwnr(ima3, PSF, R); 

imshow(fr2);
NCORR = fftshift(real(ifft2(Sn)));
ICORR = fftshift(real(ifft2(Sf)));
fr3 = deconvwnr(ima3, PSF, NCORR, ICORR); 
%imshow(fr3,[]);