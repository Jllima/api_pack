RSpec.describe ApiPack::PaginationMetaGenerator do
  let(:defaut_per_page) { ApiPack.default_per_page }

  let(:mock_request) do
    instance_double(
      'Request',
      base_url: 'localhost:3000',
      path: '/api/v1/resources'
    )
  end

  let(:total_pages) { Faker::Number.number(digits: 3) }

  describe '#call' do
    context 'when a request has page and per_page parameters is nil' do
      before do
        allow(mock_request).to receive(:params).and_return({ page: nil, per_page: nil })
      end
  
      let(:match_links) do
        {
          links: {
            self: 'localhost:3000/api/v1/resources',
            first: "localhost:3000/api/v1/resources?page=1&per_page=#{defaut_per_page}",
            next: "localhost:3000/api/v1/resources?page=2&per_page=#{defaut_per_page}",
            last: "localhost:3000/api/v1/resources?page=#{total_pages}&per_page=#{defaut_per_page}"
          },
          meta: {
            current_page: 1,
            total_pages: total_pages
          }
        }
      end
  
      subject { described_class.new(request: mock_request, total_pages: total_pages).call }
    
      it { expect(subject).to match(hash_including(match_links)) }
    end
  
    context 'when a request has page parameter' do
      let(:page) { Faker::Number.number(digits: 2) }
  
      before do
        @per_page = Faker::Number.number(digits: 2)
        allow(mock_request).to receive(:params).and_return({ page: page, per_page: @per_page })
      end
  
      let(:match_links) do
        { 
          links: {
            self: 'localhost:3000/api/v1/resources',
            first: "localhost:3000/api/v1/resources?page=1&per_page=#{@per_page}",
            last: "localhost:3000/api/v1/resources?page=#{total_pages}&per_page=#{@per_page}",
            prev: "localhost:3000/api/v1/resources?page=#{page - 1}&per_page=#{@per_page}",
            next: "localhost:3000/api/v1/resources?page=#{page + 1}&per_page=#{@per_page}"
          },
          meta: { 
            current_page: page,
            total_pages: total_pages
          }
        }
      end
  
      subject { described_class.new(request: mock_request, total_pages: total_pages).call }
    
      it { expect(subject).to match(hash_including(match_links)) }
    end

    context 'when a request has page and per_page parameters' do
      let(:page) { Faker::Number.number(digits: 2) }
  
      before do
        @per_page = Faker::Number.number(digits: 2)
        allow(mock_request).to receive(:params).and_return({ page: page, per_page: @per_page })
      end
  
      let(:match_links) do
        { 
          links: {
            self: 'localhost:3000/api/v1/resources',
            first: "localhost:3000/api/v1/resources?page=1&per_page=#{@per_page}",
            last: "localhost:3000/api/v1/resources?page=#{total_pages}&per_page=#{@per_page}",
            prev: "localhost:3000/api/v1/resources?page=#{page - 1}&per_page=#{@per_page}",
            next: "localhost:3000/api/v1/resources?page=#{page + 1}&per_page=#{@per_page}"
          },
          meta: { 
            current_page: page,
            total_pages: total_pages
          }
        }
      end
  
      subject { described_class.new(request: mock_request, total_pages: total_pages).call }
    
      it { expect(subject).to match(hash_including(match_links)) }
    end

    context 'when the page parameter is the last page' do
      before do
        allow(mock_request).to receive(:params).and_return({ page: total_pages, per_page: nil })
      end
  
      let(:match_links) do
        { 
          links: {
            self: 'localhost:3000/api/v1/resources',
            first: "localhost:3000/api/v1/resources?page=1&per_page=#{defaut_per_page}",
            last: "localhost:3000/api/v1/resources?page=#{total_pages}&per_page=#{defaut_per_page}",
            prev: "localhost:3000/api/v1/resources?page=#{total_pages - 1}&per_page=#{defaut_per_page}"
          },
          meta: { 
            current_page: total_pages,
            total_pages: total_pages
          }
        }
      end
  
      subject { described_class.new(request: mock_request, total_pages: total_pages).call }
    
      it { expect(subject).to match(hash_including(match_links)) }
    end
  end
end