ima2 =imresize(ima2,[260 260]);
[counts,binLocations] = imhist(ima2);
pdf=counts/numel(ima2);
figure;
plot(binLocations, pdf, 'b-', 'LineWidth', 2);title('PDF');
xlabel('color');ylabel('probability');
grid on;

h = fspecial('gaussian',260,1);
%g=(imfilter(ima2,h,'circular'));
%figure;
%imshow(g);

G = fftshift(fft2(ima2));
H = fftshift(fft2(h));

F = zeros(size(ima2));
R=70;
for u=1:size(ima2,1)
    for v=1:size(ima2,2)
        du = u - size(ima2,1)/2;
        dv = v - size(ima2,2)/2;
        if du^2 + dv^2 <= R^2
          F(u,v) = G(u,v)./H(u,v);
        end
    end
end
%figure,imshow(log(abs(F)),[]);
fRestored = abs(ifftshift(ifft2(F)));
fRestored2 =imresize(fRestored,[384 256]);


figure,imshow(fRestored2, []);title('After');