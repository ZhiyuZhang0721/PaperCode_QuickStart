function ret=Mutation(pmutation,chrom,sizepop,length1)
%�������
%pmutation      input      �������
%chrom          input      ����Ⱥ
%sizepop        input      ��Ⱥ��ģ
%iii            input      ��������
%MAXGEN         input      ����������
%length1        input      ���峤��
%ret            output     ����õ��Ŀ���Ⱥ
for i=1:sizepop
    %�������
    pick=rand;
    while pick==0
        pick=rand;
    end
    index=unidrnd(sizepop);
    %�ж��Ƿ����
    if pick>pmutation
        continue;
    end
    pos=unidrnd(length1);
    while pos==1
        pos=unidrnd(length1);
    end
    nchrom=chrom(index,:);
    nchrom(pos)=unidrnd(31);
    while length(unique(nchrom))==(length1-1)
          nchrom(pos)=unidrnd(31);
    end
    flag=0;
    if fitness(nchrom)<fitness(chrom(index,:))
        flag=1;
    end
    if flag==1
        chrom(index,:)=nchrom;
    end
end
ret=chrom;
end
        
        
        
