res = zeros(5*15,21);
for i = 1 : 15
    res((i-1)*5 + 1,:) = finalresults((i-1)*8 + 1,:)+finalresults((i-1)*8 + 2,:)*0.5;
    res((i-1)*5 + 2,:) = finalresults((i-1)*8 + 3,:)+finalresults((i-1)*8 + 2,:)*0.5+finalresults((i-1)*8 + 4,:)*0.5;
    res((i-1)*5 + 3,:) = finalresults((i-1)*8 + 4,:)*0.5+finalresults((i-1)*8 + 5,:)*0.5;
    res((i-1)*5 + 4,:) = finalresults((i-1)*8 + 6,:)+finalresults((i-1)*8 + 5,:)*0.5+finalresults((i-1)*8 + 7,:)*0.5;
    res((i-1)*5 + 5,:) = finalresults((i-1)*8 + 8,:)+finalresults((i-1)*8 + 7,:)*0.5;
end
    