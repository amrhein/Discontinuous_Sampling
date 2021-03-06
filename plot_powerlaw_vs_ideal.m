L = 50; % number of values used for plotting
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

beta = .5;
out5 = integrate_powerlaw_vs_ideal(tbv,tsv,t0v,beta);

beta = 1.5;
out15 = integrate_powerlaw_vs_ideal(tbv,tsv,t0v,beta);

%%
addpath ../../export_fig
outvec = {'5' '15'};
bvec = {'0.5','1.5'};

for ii = 1:length(outvec)

    figure()
    set(gcf,'color','w','position',[440   518   403   280])
    
    ploutv = eval(['out' outvec{ii}]);
    plout = reshape(ploutv,length(tbR),length(tsR));
    
    hold on

    [C,h] = contour(tbR,tsR,plout,[0.01,0.05,0.1:0.1:.8],'k');
    contour(tbR,tsR(2:end),diff(plout),[0,0],'k','linewidth',2);
    clabel(C,h)
    grid on
    ylabel('\tau_s (years)','fontsize',12)
    xlabel('\tau_b (years)','fontsize',12)
    axis tight
    axis square
    %title(['\beta = ' bvec{ii}],'fontsize',14,'fontweight','bold')
    set(gca,'XTick',get(gca,'YTick'))
    set(gca,'XTickLabelRotation',45,'fontsize',12)
    set(gca,'YTick',get(gca,'XTick'))
    export_fig('-pdf',['Figs/errors_wrt_beta_vs_ideal_' char(outvec(ii)) '_tau0_' num2str(t0)])    
end

