L = 50;
t0 = 20000;
tbMIN = 10;
tbMAX = 2000;
tsMIN = 10;
tsMAX = 2000;

tbR = linspace(tbMIN,tbMAX,L);
tsR = linspace(tsMIN,tsMAX,L);


tbv = repmat(tbR,L,1);
tsv = repmat(tsR,L,1)';
t0v = repmat(t0,L,L);

notuse = tbv(:)>tsv(:);
tbv(notuse) = []; tsv(notuse) = []; t0v(notuse) = [];

beta = .5;
out5 = integrate_powerlaw(tbv,tsv,t0v,beta);

beta = 1.5;
out15 = integrate_powerlaw(tbv,tsv,t0v,beta);

%%
addpath ../../export_fig
outvec = {'5' '15'};
bvec = {'0.5','1.5'};


for ii = 1:length(outvec)

    figure()    
    set(gcf,'color','w','position',[440   518   403   280])

    plout = zeros(L,L)-eps;
    plout(~notuse) = eval(['out' outvec{ii}]);
    hold on
    [C,h] = contour(tbR,tsR,plout,[0.01,0.05,0.1:0.1:.8],'k');
    clabel(C,h)
    [C,h] = contour(tbR,tsR,plout,[0,0],'k','linewidth',2);
    clabel(C,h)
    ylabel('\tau_{ts} (years)','fontsize',12)
    xlabel('\tau_b (years)','fontsize',12)
    grid on
    axis tight
    axis square
    %text(400,200,['\beta = ' bvec{ii}],'fontsize',14,'fontweight','bold')
    set(gca,'XTick',get(gca,'YTick'))
    set(gca,'XTickLabelRotation',45,'fontsize',12)
    set(gca,'YTick',get(gca,'XTick'))
    export_fig('-pdf',['Figs/errors_wrt_beta_' char(outvec(ii)) '_tau0_' num2str(t0)])    
    
end


